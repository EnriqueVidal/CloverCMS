Factory.define :user do |f|
  f.email 'user@email.com'
  f.password 'somepassword'
  f.password_confirmation 'somepassword'
end

Factory.define :admin, :parent => :user do |f|
  f.admin true
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