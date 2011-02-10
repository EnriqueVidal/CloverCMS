# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

section = Section.create! :name => 'main'
pages   = Page.create! :name => 'main page', :content => 'this is my main page', :section_id => section.id, :home_page => true, :published => true

user    = User.create! :username => 'admin', :password => 'administrator', :confirmed_at => Time.now, :email => "admin@example.com"
user.admin = true
user.save!

Setting.create! :name => 'theme', :value => 'default', :destroyable => false, :description => 'This is the theme of your site.'
