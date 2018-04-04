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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180404223255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "collaborators", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "email"
    t.string "major"
    t.integer "graduation"
    t.string "active"
    t.string "at_collaborator_table_id"
    t.string "at_collaborator_id"
    t.string "at_collaborator_table_time_created"
  end

  create_table "images", force: :cascade do |t|
    t.string "at_image_id"
    t.string "url"
    t.string "filename"
    t.integer "size"
    t.string "small_thumbnail_url"
    t.integer "small_thumbnail_width"
    t.integer "small_thumbnail_height"
    t.string "large_thumbnail_url"
    t.integer "large_thumbnail_width"
    t.integer "large_thumbnail_height"
    t.string "at_images_table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_type"
    t.string "image_category"
    t.string "at_locations_table_id"
    t.string "primary_site_name"
    t.string "view_direction"
    t.string "secondary_site_name"
    t.string "secondary_site_kingdom"
    t.integer "number_of_watchtowers"
    t.string "exterior_features"
    t.string "status"
    t.string "fortress_features"
    t.string "at_images_table_time_created"
    t.integer "page_number"
    t.string "source"
    t.integer "slug"
    t.string "agol_slide_embed"
  end

  create_table "locations", force: :cascade do |t|
    t.string "at_locations_table_id"
    t.integer "itinerary_order"
    t.string "primary_site_name"
    t.string "latitude"
    t.string "longitude"
    t.string "wikipedia_link"
    t.string "fortalezas_link"
    t.string "castillosnet_link"
    t.string "at_collaborator_id"
    t.string "a360_3D_model_link"
    t.string "at_locations_table_time_created"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.geography "lonlat", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}
    t.string "slug"
    t.string "a360_3D_model_embed"
    t.string "agol_map_location_embed"
    t.string "agol_map_location_link"
  end

  create_table "perspective_drawings", force: :cascade do |t|
    t.string "at_locations_table_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
