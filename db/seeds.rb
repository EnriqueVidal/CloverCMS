# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

section = Section.create({ :name => 'main' })
pages   = Page.create({ :name => 'main page', :content => 'this is my main page', :section_id => section.id, :home_page => true, :published => true })
SiteConfig.create!
