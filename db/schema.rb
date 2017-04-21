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

ActiveRecord::Schema.define(:version => 20170421184723) do

  create_table "alums", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "grad_year"
    t.string   "staff_position"
    t.string   "job_now"
    t.string   "where_you_live"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "archives", :force => true do |t|
    t.string   "title"
    t.string   "link"
    t.integer  "wp_post_id"
    t.datetime "wp_post_date"
    t.text     "content"
    t.string   "creator"
    t.string   "status"
    t.string   "category"
    t.string   "author"
    t.text     "excerpt"
    t.string   "post_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "tags"
    t.string   "subtitle"
    t.text     "formatted_content"
    t.text     "pullquote"
    t.string   "first_image_url"
    t.integer  "column_width",      :default => 1
    t.string   "illustrator"
  end

  add_index "archives", ["status"], :name => "index_archives_on_status"
  add_index "archives", ["wp_post_date"], :name => "index_archives_on_wp_post_date"

  create_table "articles", :force => true do |t|
    t.text     "by"
    t.text     "body"
    t.string   "title"
    t.datetime "published_at"
    t.string   "category"
    t.string   "tags"
    t.text     "promo"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "subtitle"
    t.string   "hero_file_name"
    t.string   "hero_content_type"
    t.integer  "hero_file_size"
    t.datetime "hero_updated_at"
    t.string   "hero_caption"
    t.decimal  "hero_x"
    t.decimal  "hero_y"
    t.text     "excerpt"
    t.text     "pullquote"
    t.string   "first_image_url"
    t.boolean  "published",         :default => false
    t.boolean  "has_hero",          :default => false
    t.integer  "column_width",      :default => 1
    t.string   "illustrator"
    t.integer  "issue_id"
    t.boolean  "featured",          :default => false
  end

  add_index "articles", ["published"], :name => "index_articles_on_published"
  add_index "articles", ["published_at"], :name => "index_articles_on_published_at"

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "emails", :force => true do |t|
    t.string   "email"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "issues", :force => true do |t|
    t.string   "title"
    t.date     "date"
    t.string   "document_number"
    t.string   "url_slug"
    t.boolean  "published"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "scribd",             :default => false
    t.string   "image_url"
    t.string   "cover_file_name"
    t.string   "cover_content_type"
    t.integer  "cover_file_size"
    t.datetime "cover_updated_at"
  end

  add_index "issues", ["date"], :name => "index_issues_on_date"

  create_table "thelists", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "title_file_name"
    t.string   "title_content_type"
    t.integer  "title_file_size"
    t.datetime "title_updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.boolean  "admin"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
