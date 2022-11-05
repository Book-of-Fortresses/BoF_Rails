require 'httparty'

def new_location_image
  Image.create!(
    "at_image_id" => @at_image_id,
    "url" => @url,
    "filename" => @filename,
    "size" => @size,
    "image_type" => @image_type,
    "image_category" => @image_category,
    "small_thumbnail_url" => @small_thumbnail_url,
    "small_thumbnail_width" => @small_thumbnail_width,
    "small_thumbnail_height" => @small_thumbnail_height,
    "large_thumbnail_url" => @large_thumbnail_url,
    "large_thumbnail_width" => @large_thumbnail_width,
    "large_thumbnail_height" => @large_thumbnail_height,
    "at_locations_table_id" => @at_locations_table_id
  )
end

def attachment_fields(image)
  @at_image_id = image.try(:[], "id")
  @url = image["url"]
  @filename = image["filename"]
  @size = image["size"]
  @image_type = image["type"]
  @small_thumbnail_url = image.try(:[], "thumbnails").try(:[], "small").try(:[], "url")
  @small_thumbnail_width = image.try(:[], "thumbnails").try(:[], "small").try(:[], "width")
  @small_thumbnail_height = image.try(:[], "thumbnails").try(:[], "small").try(:[], "height")
  @large_thumbnail_url = image.try(:[], "thumbnails").try(:[], "large").try(:[], "url")
  @large_thumbnail_width = image.try(:[], "thumbnails").try(:[], "large").try(:[], "width")
  @large_thumbnail_height = image.try(:[], "thumbnails").try(:[], "large").try(:[], "height")
end

namespace :db do

  desc "Import collaborators from Airtable"
  task :load_collaborators => [:environment] do
    url = 'https://api.airtable.com/v0/appTZa4lVuewDsuyA/Collaborators'
    response = HTTParty.get(url, headers: {"Authorization" => ENV['AIRTABLE_TOKEN']})
    collaborators_json = response.parsed_response["records"].to_a

    collaborators_json.each do |record|
      name = record["fields"]["name"]
      at_collaborator_table_id = record["id"]
      major = record["fields"]["major"]
      if record["fields"]["collaborator"]
        at_collaborator_id = record["fields"]["collaborator"]["id"]
        email = record["fields"]["collaborator"]["email"]
      end
      graduation = record["fields"]["graduation"]
      active = record["fields"]["active"]
      at_collaborator_table_time_created = record["createdTime"]

      Collaborator.create!(
        "name" => name,
        "email" => email,
        "major" => major,
        "graduation" => graduation,
        "active" => active,
        "at_collaborator_table_id" => at_collaborator_table_id,
        "at_collaborator_id" => at_collaborator_id,
        "at_collaborator_table_time_created" => at_collaborator_table_time_created
      )
    end
  end

  desc "Import images from Airtable"
  offset = ''
  task :load_images => [:environment] do
    url = 'https://api.airtable.com/v0/appTZa4lVuewDsuyA/Images/?offset='+offset
    response = HTTParty.get(url, headers: {"Authorization" => ENV['AIRTABLE_TOKEN']})
    # saves offset value from end of json to submit with next request
    if response.parsed_response["offset"]
      offset = response.parsed_response["offset"]
    else
      offset = ''
    end
    puts "offset: " + offset

    images_json = response.parsed_response["records"].to_a
    # puts images_json
    images_json.each do |record|
      # puts record["fields"]["primary_site_name"]
      # puts record["fields"]["image"]
      at_images_table_id = record["id"]
      page_number = record["fields"].try(:[], "page_number")
      slug = record["fields"]["slug"]
      primary_site_name = record["fields"]["primary_site_name"]
      view_direction = record["fields"]["view_direction"]
      image_category = record["fields"]["category"]
      source = record["fields"]["source"]
      secondary_site_name = record["fields"]["secondary_site_name"]
      secondary_site_kingdom = record["fields"]["secondary_site_kingdom"]
      number_of_watchtowers = record["fields"]["number_of_watchtowers"]
      agol_slide_embed = record["fields"]["agol_slide_embed"]

      if record["fields"]["exterior_features"]
        exterior_features = record["fields"]["exterior_features"].join(", ")
      end

      if record["fields"]["location_id"]
        at_locations_table_id = record["fields"]["location_id"].join(", ")
      end

      status = record["fields"]["status"]

      if record["fields"]["fortress_features"]
        fortress_features = record["fields"]["fortress_features"].join(", ")
      end

      at_images_table_time_created = record["fields"]["createdTime"]

      begin
        record["fields"]["image"].each do |image|
          attachment_fields(image)
          Image.create!(
            # directly from images table:
            "slug" => slug,
            "at_images_table_id" => at_images_table_id,
            "at_locations_table_id" => at_locations_table_id,
            "image_category" => image_category,
            "source" => source,
            "page_number" => page_number,
            "primary_site_name" => primary_site_name,
            "view_direction" => view_direction,
            "secondary_site_name" => secondary_site_name,
            "secondary_site_kingdom" => secondary_site_kingdom,
            "number_of_watchtowers" => number_of_watchtowers,
            "exterior_features" => exterior_features,
            "status" => status,
            "fortress_features" => fortress_features,
            "agol_slide_embed" => agol_slide_embed,
            "at_images_table_time_created" => at_images_table_time_created,

            # from attachment_fields method
            "at_image_id" => @at_image_id,
            "url" => @url,
            "filename" => @filename,
            "size" => @size,
            "image_type" => @image_type,
            "small_thumbnail_url" => @small_thumbnail_url,
            "small_thumbnail_width" => @small_thumbnail_width,
            "small_thumbnail_height" => @small_thumbnail_height,
            "large_thumbnail_url" => @large_thumbnail_url,
            "large_thumbnail_width" => @large_thumbnail_width,
            "large_thumbnail_height" => @large_thumbnail_height,
          )
        end
      rescue
        puts record
        puts primary_site_name
        puts view_direction
      end
    end

    # Rerun load_images until no offset is returned
    if offset != ''
      Rake::Task["db:load_images"].execute
    else
      puts "Finished loading all the images!"
    end
  end

  desc "Import locations from Airtable"
  task :load_locations => [:environment] do
    url = 'https://api.airtable.com/v0/appTZa4lVuewDsuyA/Locations'
    response = HTTParty.get(url, headers: {"Authorization" => ENV['AIRTABLE_TOKEN']})
    locations_json = response.parsed_response["records"].to_a

    locations_json.each do |record|
      slug = record["fields"]["slug"]
      @at_locations_table_id = record["id"]
      itinerary_order = record["fields"]["itinerary_order"]
      primary_site_name = record["fields"]["primary_site_name"]
      latitude = record["fields"]["latitude"]
      longitude = record["fields"]["longitude"]
      lonlat = "POINT("+longitude.to_s+" "+latitude.to_s+")"
      at_perspective_drawings_ids = record["fields"]["drawings"]
      wikipedia_link = record["fields"]["wikipedia_link"]
      fortalezas_link = record["fields"]["fortalezas_link"]
      castillosnet_link = record["fields"]["castillosnet_link"]

      if record["fields"]["collaborator"]
        collaborators = []
        record["fields"]["collaborator"].each do |collaborator|
          collaborators.push(collaborator["id"])
        end
        at_collaborator_id = collaborators.join(',')
      end

      if record["fields"]["stage"]
        stage = record["fields"]["stage"].join(", ")
      end

      a360_3D_model_link = record["fields"]["A360_3D_model_link"]
      a360_3D_model_embed = record["fields"]["a360_3D_model_embed"]
      agol_map_location_link = record["fields"]["agol_map_location_link"]
      agol_map_location_embed = record["fields"]["agol_map_location_embed"]
      at_locations_table_time_created = record["createdTime"]

      if record["fields"]["transcript"]
        record["fields"]["transcript"].each do |image|
          @image_category = "transcript"
          attachment_fields(image)
          new_location_image
        end
      end

      if record["fields"]["satellite_image"]
        record["fields"]["satellite_image"].each do |image|
          @image_category = "satellite image"
          attachment_fields(image)
          new_location_image
        end
      end

      Location.create!(
        "at_locations_table_id" => @at_locations_table_id,
        "itinerary_order" => itinerary_order,
        "primary_site_name" => primary_site_name,
        "slug" => slug,
        "stage" => stage,
        "latitude" => latitude,
        "longitude" => longitude,
        "lonlat" => lonlat,
        "wikipedia_link" => wikipedia_link,
        "fortalezas_link" => fortalezas_link,
        "castillosnet_link" => castillosnet_link,
        "at_collaborator_id" => at_collaborator_id,
        "a360_3D_model_link" => a360_3D_model_link,
        "a360_3D_model_embed" => a360_3D_model_embed,
        "agol_map_location_link" => agol_map_location_link,
        "agol_map_location_embed" => agol_map_location_embed,
        "at_locations_table_time_created" => at_locations_table_time_created
      )
    end
  end

  desc "Import events from Airtable"
  offset = ''
  task :load_events => [:environment] do
    url = 'https://api.airtable.com/v0/appTZa4lVuewDsuyA/Events/?offset='+offset
    response = HTTParty.get(url, headers: {"Authorization" => ENV['AIRTABLE_TOKEN']})

    # saves offset value from end of json to submit with next request
    if response.parsed_response["offset"]
      offset = response.parsed_response["offset"]
    else
      offset = ''
    end
    puts "offset: " + offset

    events_json = response.parsed_response["records"].to_a

    events_json.each do |record|
      at_event_id = record["id"]
      notes = record["fields"]["Notes"]

      if record["fields"]["location_link"]
        at_location_id = record["fields"]["location_link"].first
      end

      date_type = record["fields"]["date_type"]
      end_date = record["fields"]["end date"]
      earliest_begin_date = record["fields"]["Earliest begin date"]
      order = record["fields"]["Order"]

      major_event_type = record["fields"]["Major Event Type"]

      Event.create!(
        "at_event_id" => at_event_id,
        "notes" => notes,
        "at_location_id" => at_location_id,
        "date_type" => date_type,
        "end_date" => end_date,
        "earliest_begin_date" => earliest_begin_date,
        "order" => order,
        "major_event_type" => major_event_type
      )
    end

    # Rerun load_images until no offset is returned
    if offset != ''
      Rake::Task["db:load_events"].execute
    else
      puts "Finished loading all #{Event.count} events!"
    end
  end
end
