Factory.define :user do |f|
  f.username 'user'
  f.email 'user@email.com'
  f.password 'somepassword'
  f.password_confirmation 'somepassword'
end

Factory.define :page do |f|
  f.name 'My new page'
  f.published true
  f.content 'This is my super page'
  f.section_id 0
end

Factory.define :section do |f|
  f.name 'Main'
end

Factory.define :article do |f|
  f.name 'First article'
  f.content 'This is my first article'
end

Factory.define :setting do |s|
  s.name 'new_setting'
  s.value 'new_value'
  s.description 'This is our new setting it rocks. :)'
end
