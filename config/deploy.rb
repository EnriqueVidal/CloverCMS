set :subdomain,   "demo"
set :domain,      "cloverinteractive.com"
set :application, "clovercms"
set :repository,  "git://github.com/EnriqueVidal/CloverCMS.git"

set :user,            :cloverin
set :use_sudo,        false
set :group_writable,  false
set :keep_releases,   1

set :scm,         :git
set :branch,      :development
set :scm_verbose, true

role :web, "#{subdomain}.#{domain}"
role :app, "#{subdomain}.#{domain}"
role :db,  "#{subdomain}.#{domain}", :primary => true

set :deploy_to, "/home/#{user}/rails_apps/#{subdomain}.#{domain}/#{application}"

require 'config/capistrano_templates'

namespace :deploy do
  task :start do ; end
  task :stop  do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :cold do
    update

    run "rm -fr #{release_path}/vendor"
    cloverinteractive::missing_folders
    cloverinteractive::missing_gems
    cloverinteractive::link_public
  end

  namespace :cloverinteractive do
    desc "Create missing shared folders"
    task :missing_folders do
      run "ln -s #{shared_path}/vendor #{current_path}/vendor"
      run "ln -s #{shared_path}/public/.htaccess #{current_path}/public/.htaccess"
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

