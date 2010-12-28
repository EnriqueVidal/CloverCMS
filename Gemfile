source 'http://rubygems.org'

gem 'rails',          '3.0.3'
gem 'will_paginate',  '3.0.pre2'
gem 'haml-rails'
gem 'devise'
gem 'paperclip'
gem 'acts-as-taggable-on'
gem 'capistrano'
gem 'mime-types', :require => 'mime/types'

group :test, :development do
  gem 'sqlite3-ruby',   :require => 'sqlite3'
end

group :test do
  gem 'factory_girl_rails'
  gem 'mocha',          :require => false
  gem 'redgreen',       :require => false
  gem 'turn'
end

group :production do
  gem 'mysql', '2.7'
end