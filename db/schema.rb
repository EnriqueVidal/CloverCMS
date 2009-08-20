# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090820161104) do

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "body"
    t.string   "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "subsection_id"
  end

  create_table "people", :force => true do |t|
    t.string   "first_name",         :limit => 40, :default => "", :null => false
    t.string   "middle_name",        :limit => 40
    t.string   "last_name",          :limit => 40, :default => "", :null => false
    t.date     "date_of_birth"
    t.integer  "user_id"
    t.string   "type"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.string   "gender",             :limit => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rights", :force => true do |t|
    t.string   "name"
    t.string   "controller"
    t.string   "action"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rights_roles", :id => false, :force => true do |t|
    t.integer "right_id"
    t.integer "role_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subsections", :force => true do |t|
    t.string   "name"
    t.integer  "section_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",           :limit => 40, :null => false
    t.string   "password"
    t.string   "password_salt"
    t.string   "token"
    t.date     "activation_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

end
