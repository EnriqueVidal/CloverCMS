# We crate our default section and page to avoid CMS errors

section = Section.create! :name => 'main'
pages   = Page.create! :name => 'main page', :content => 'this is my main page', :section_id => section.id, :home_page => true, :published => true

# We create and activate a default user

user    = User.create! :username => 'admin', :password => 'administrator', :email => "admin@example.com"
user.confirmed_at = Time.now
user.admin = true
user.save!

# We create the default non-destroyable site settings

default_settings =  [
                      {
                        :name         => 'theme',
                        :value        => 'default',
                        :description  => 'This is the theme of your site.'
                      },
                      {
                        :name         => 'site_name',
                        :value        => 'CloverInteractive',
                        :description  => 'This is your site name.'
                      },
                      {
                        :name         => 'footer',
                        :value        => 'This site is powered by <a href="http://cloverinteractive.com">CloverInteractive</a>',
                        :description  => "This is your site's footer."
                      }
                    ]

default_settings.each do |setting|
  setting = Setting.create! setting
  setting.destroyable = false
  setting.save!
end
