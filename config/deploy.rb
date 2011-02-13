set :domain,      "demo.cloverinteractive.com"
set :application, "clovercms"
set :repository,  "git://github.com/EnriqueVidal/CloverCMS.git"

set :user,            :cloverin
set :use_sudo,        false
set :group_writable,  false
set :keep_releases,   1

set :scm,         :git
set :branch,      :development
set :scm_verbose, true

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :deploy_to, "/home/#{user}/rails_apps/#{domain}/#{application}"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :cold do
    update
    put File.read(File.join(File.dirname(__FILE__), '../public/.htaccess')),  File.join(current_release, 'public', '.htaccess')
    run "cd #{current_path} && rm -fr vendor"

    cloverinteractive::missing_folders
    cloverinteractive::missing_gems
    cloverinteractive::link_public
  end

  namespace :cloverinteractive do
    desc "Create missing shared folders"
    task :missing_folders do
      run "cd #{deploy_to}; mkdir -p shared/log shared/system shared/pids shared/vendor"
      run "ln -s #{deploy_to}/shared/vendor #{current_path}/vendor"
    end

    desc "Install missing gems"
    task :missing_gems do
      run "cd #{current_path} && bundle install --without development test --path vendor/bundle"
    end

    desc "Link #{current_path}/public to $HOME/demo"
    task :link_public do
      run "cd /home/#{user}; ln -s #{current_path}/public demo"
    end
  end
end
