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

ActiveRecord::Schema.define(:version => 20130507164728) do

  create_table "matches", :force => true do |t|
    t.integer  "player_id"
    t.integer  "tournament_id"
    t.integer  "player_1_game_1_score"
    t.integer  "player_1_game_2_score"
    t.integer  "player_2_game_1_score"
    t.integer  "player_2_game_2_score"
    t.string   "status"
    t.integer  "round"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "matches_players", :force => true do |t|
    t.integer "player_id"
    t.integer "match_id"
  end

  create_table "players", :force => true do |t|
    t.string   "name"
    t.integer  "match_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tournament_players", :force => true do |t|
    t.integer  "player_id"
    t.integer  "tournament_id"
    t.integer  "match_points",  :default => 0
    t.integer  "prestige",      :default => 0
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.string   "name"
    t.integer  "match_id"
    t.integer  "round"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
