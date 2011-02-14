unless Capistrano::Configuration.respond_to?(:instance)
  abort "This extension requires Capistrano 2"
end

Capistrano::Configuration.instance.load do
  namespace :deploy do
    namespace :db do

      desc <<-DESC
        Creates the database.yml configuration file in shared path.

        By default, this task uses a template unless a template \
        called database.yml.erb is found either is :template_dir \
        or /config/deploy folders. The default template matches \
        the template for config/database.yml file shipped with Rails.

        When this recipe is loaded, db:setup is automatically configured \
        to be invoked after deploy:setup. You can skip this task setting \
        the variable :skip_db_setup to true. This is especially useful \
        if you are using this recipe in combination with \
        capistrano-ext/multistaging to avoid multiple db:setup calls \
        when running deploy:setup for all stages one by one.
      DESC
      task :setup, :except => { :no_release => true } do

        default_template = <<-EOF
        base: &base
          adapter: sqlite3
          timeout: 5000
        development:
          database: #{shared_path}/db/development.sqlite3
          <<: *base
        test:
          database: #{shared_path}/db/test.sqlite3
          <<: *base
        production:
          database: #{shared_path}/db/production.sqlite3
          <<: *base
        EOF

        database = fetch(:template_dir, "config/deploy") + '/database.yml.erb'
        htaccess = fetch(:template_dir, "config/deploy") + '/htaccess.erb'

        database_template = File.file?(database) ? File.read(database) : default_template
        database_config = ERB.new(database_template)

        if File.file?(htaccess)
          htaccess_template = File.read(htaccess)
          apache_config = ERB.new(htaccess_template)
        end

        run "mkdir -p #{shared_path}/db"
        run "mkdir -p #{shared_path}/config"
        run "mkdir -p #{shared_path}/vendor"
        run "mkdir -p #{shared_path}/public"

        put database_config.result(binding), "#{shared_path}/config/database.yml"
        put apache_config.result(binding), "#{shared_path}/public/.htaccess" if !apache_config.nil?
      end

      desc <<-DESC
        [internal] Updates the symlink for database.yml file to the just deployed release.
      DESC
      task :symlink, :except => { :no_release => true } do
        run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      end

    end

    after "deploy:setup",           "deploy:db:setup"   unless fetch(:skip_db_setup, false)
    after "deploy:finalize_update", "deploy:db:symlink"
  end
end

