source 'http://rubygems.org'

gem 'rails',          '3.0.3'
gem 'haml',           '3.0.18'
gem 'will_paginate',  '3.0.pre2'
gem 'devise'
gem 'paperclip'
gem 'hpricot'
gem 'ruby_parser'
gem 'acts-as-taggable-on'
gem 'omniauth'
gem 'mime-types', :require => 'mime/types'

# Deploy with Capistrano
gem 'capistrano'

group :development do
  gem 'mongrel', '1.2.0.pre2'
end

group :test, :development do
  gem 'sqlite3-ruby',   :require => 'sqlite3'
end

group :test do
  gem 'factory_girl'
  gem 'mocha',          :require => false
  gem 'redgreen',       :require => false
  gem 'turn'
end

group :production do
  gem 'mysql', '2.7'
end