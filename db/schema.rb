# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130203225023) do

  create_table "achievements", :force => true do |t|
    t.integer  "title_id"
    t.integer  "event_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "animal_breeders", :force => true do |t|
    t.integer  "animal_id"
    t.integer  "breeder_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "animal_kennels", :force => true do |t|
    t.integer  "animal_id"
    t.integer  "kennel_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "animal_owners", :force => true do |t|
    t.integer  "animal_id"
    t.integer  "owner_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "animals", :force => true do |t|
    t.string   "name"
    t.string   "call_name"
    t.integer  "mother_id"
    t.integer  "father_id"
    t.string   "sex"
    t.integer  "litter_id"
    t.integer  "address_id"
    t.date     "birth"
    t.integer  "birth_id"
    t.date     "death"
    t.integer  "death_id"
    t.string   "import_json"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "animals", ["birth"], :name => "index_animals_on_birth"
  add_index "animals", ["death"], :name => "index_animals_on_death"
  add_index "animals", ["father_id"], :name => "index_animals_on_father_id"
  add_index "animals", ["litter_id"], :name => "index_animals_on_litter_id"
  add_index "animals", ["mother_id"], :name => "index_animals_on_mother_id"
  add_index "animals", ["sex"], :name => "index_animals_on_sex"

  create_table "certifications", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clearances", :force => true do |t|
    t.integer  "animal_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dominates", :force => true do |t|
    t.integer  "dominator_id"
    t.integer  "dominated_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "entity_id"
    t.string   "integer"
    t.string   "entity_type"
    t.string   "string"
    t.string   "type"
    t.date     "date"
    t.time     "time"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "kennel_litters", :force => true do |t|
    t.integer  "kennel_id"
    t.integer  "litter_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kennels", :force => true do |t|
    t.string   "name"
    t.integer  "address_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "litters", :force => true do |t|
    t.integer  "mother_id"
    t.integer  "father_id"
    t.integer  "event_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "locations", :force => true do |t|
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "resolution"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "offspring_litters", :force => true do |t|
    t.integer  "litter_id"
    t.integer  "offspring_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "people", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "address_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "person_kennels", :force => true do |t|
    t.integer  "person_id"
    t.integer  "kennel_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "preceeds", :force => true do |t|
    t.integer  "first"
    t.integer  "second"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "registrations", :force => true do |t|
    t.integer  "registry_id"
    t.integer  "animal_id"
    t.integer  "registration_number"
    t.date     "date"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "succeeds", :force => true do |t|
    t.integer  "first"
    t.integer  "second"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "titles", :force => true do |t|
    t.integer  "registry_id"
    t.string   "name"
    t.string   "abbreviation"
    t.boolean  "prefix"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
