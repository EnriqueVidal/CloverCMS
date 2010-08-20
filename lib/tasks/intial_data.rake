require 'initial_data'

namespace :db do
  desc "This will import the initial data of this app (admin user, roles, rights, sections)"
  task :initial_data => :environment do
    puts ">>>>> Importing Initial Data <<<<<"
    InitialData.import_data
  end
end