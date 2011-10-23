# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111023152507) do

  create_table "councils", :force => true do |t|
    t.string   "councilname"
    t.integer  "councilnumber"
    t.string   "twitterurl"
    t.string   "facebookurl"
    t.string   "linkedinurl"
    t.string   "googleplusurl"
    t.string   "email"
    t.string   "posterousurl"
    t.string   "calendarurl"
    t.text     "about"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "mobileurl"
  end

  create_table "events", :force => true do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.string   "eventlocation"
    t.integer  "user_id"
  end

  create_table "posts", :force => true do |t|
    t.string   "postname"
    t.text     "postbody"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.boolean  "privateflag"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.integer  "degree"
    t.string   "twitter"
    t.string   "facebook"
    t.string   "googleplus"
    t.boolean  "member"
    t.boolean  "officer"
    t.string   "officertitle"
    t.string   "linkedin"
    t.string   "fullname"
    t.boolean  "publisher"
    t.integer  "council_id"
  end

end
