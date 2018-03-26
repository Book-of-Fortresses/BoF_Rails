require 'httparty'

namespace :db do

  desc "import collaborators from airtable"
  task :load_collaborators => [:environment] do
    url = 'https://api.airtable.com/v0/appTZa4lVuewDsuyA/Collaborators'
    response = HTTParty.get(url, headers: {"Authorization" => ENV['AIRTABLE_TOKEN']})

    collaborators_json = response.parsed_response["records"].to_a
    collaborators_json.each do |record|
      name = record["fields"]["name"]
      at_collaborator_table_id = record["id"]
      major = record["fields"]["major"]
      at_collaborator_id = record["fields"]["collaborator"]["id"]
      email = record["fields"]["collaborator"]["email"]
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

  desc "import perspective drawings from airtable"
  task :load_perspective_drawings => [:environment] do
    url = 'https://api.airtable.com/v0/appTZa4lVuewDsuyA/Perspective_Drawings/'
    response = HTTParty.get(url, headers: {"Authorization" => ENV['AIRTABLE_TOKEN']})

    perspective_drawings_json = response.parsed_response["records"].to_a

    perspective_drawings_json.each do |record|
      at_perspective_drawings_table_id = record["id"]
        page_number = record["fields"].try(:[], "page_number")

        primary_site_name = record["fields"]["primary_site_name"]
        view_direction = record["fields"]["view_direction"]
        image_category = record["fields"]["category"].join(", ")
        source = record["fields"]["source"]
        secondary_site_name = record["fields"]["secondary_site_name"]
        secondary_site_kingdom = record["fields"]["secondary_site_kingdom"]
        number_of_watchtowers = record["fields"]["number_of_watchtowers"]
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
        at_perspective_drawings_table_time_created = record["fields"]["createdTime"]

        record["fields"]["image"].each do |image|
          at_image_id = image.try(:[], "id")
          url = image["url"]
          filename = image["filename"]
          size = image["size"]
          image_type = image["type"]
          small_thumbnail_url = image.try(:[], "thumbnails").try(:[], "small").try(:[], "url")
          small_thumbnail_width = image.try(:[], "thumbnails").try(:[], "small").try(:[], "width")
          small_thumbnail_height = image.try(:[], "thumbnails").try(:[], "small").try(:[], "height")

          large_thumbnail_url = image.try(:[], "thumbnails").try(:[], "large").try(:[], "url")
          large_thumbnail_width = image.try(:[], "thumbnails").try(:[], "large").try(:[], "width")
          large_thumbnail_height = image.try(:[], "thumbnails").try(:[], "large").try(:[], "height")

          Image.create!(
            "at_image_id" => at_image_id,
            "at_perspective_drawings_table_id" => at_perspective_drawings_table_id,
            "at_locations_table_id" => at_locations_table_id,
            "url" => url,
            "filename" => filename,
            "size" => size,
            "image_type" => image_type,
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
            "at_perspective_drawings_table_time_created" => at_perspective_drawings_table_time_created,
            "small_thumbnail_url" => small_thumbnail_url,
            "small_thumbnail_width" => small_thumbnail_width,
            "small_thumbnail_height" => small_thumbnail_height,
            "large_thumbnail_url" => large_thumbnail_url,
            "large_thumbnail_width" => large_thumbnail_width,
            "large_thumbnail_height" => large_thumbnail_height,
          )
        end
    end
  end

  desc "import locations from airtable"
  task :load_locations => [:environment] do
    url = 'https://api.airtable.com/v0/appTZa4lVuewDsuyA/Locations'
    response = HTTParty.get(url, headers: {"Authorization" => ENV['AIRTABLE_TOKEN']})

    locations_json = response.parsed_response["records"].to_a

    locations_json.each do |record|
      slug = record["fields"]["slug"]
      at_locations_table_id = record["id"]
      location_id = record["fields"]["id_number"]
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
      a360_3D_model_link = record["fields"]["A360_3D_model_link"]
      a360_3D_model_embed = record["fields"]["a360_3D_model_embed"]
      agol_map_location_link = record["fields"]["agol_map_location_link"]
      agol_map_location_embed = record["fields"]["agol_map_location_embed"]
      at_locations_table_time_created = record["createdTime"]
      if record["fields"]["transcript"]
      record["fields"]["transcript"].each do |image|
        at_image_id = image.try(:[], "id")
        url = image["url"]
        filename = image["filename"]
        size = image["size"]
        image_type = image["type"]
        small_thumbnail_url = image.try(:[], "thumbnails").try(:[], "small").try(:[], "url")
        small_thumbnail_width = image.try(:[], "thumbnails").try(:[], "small").try(:[], "width")
        small_thumbnail_height = image.try(:[], "thumbnails").try(:[], "small").try(:[], "height")
        large_thumbnail_url = image.try(:[], "thumbnails").try(:[], "large").try(:[], "url")
        large_thumbnail_width = image.try(:[], "thumbnails").try(:[], "large").try(:[], "width")
        large_thumbnail_height = image.try(:[], "thumbnails").try(:[], "large").try(:[], "height")

        Image.create!(
          "at_image_id" => at_image_id,
          "url" => url,
          "filename" => filename,
          "size" => size,
          "image_type" => image_type,
          "image_category" => "transcript",
          "small_thumbnail_url" => small_thumbnail_url,
          "small_thumbnail_width" => small_thumbnail_width,
          "small_thumbnail_height" => small_thumbnail_height,
          "large_thumbnail_url" => large_thumbnail_url,
          "large_thumbnail_width" => large_thumbnail_width,
          "large_thumbnail_height" => large_thumbnail_height,
          "at_locations_table_id" => at_locations_table_id
        )
      end
    end

    if record["fields"]["satellite_image"]
    record["fields"]["satellite_image"].each do |image|
      at_image_id = image.try(:[], "id")
      url = image["url"]
      filename = image["filename"]
      size = image["size"]
      image_type = image["type"]
      small_thumbnail_url = image.try(:[], "thumbnails").try(:[], "small").try(:[], "url")
      small_thumbnail_width = image.try(:[], "thumbnails").try(:[], "small").try(:[], "width")
      small_thumbnail_height = image.try(:[], "thumbnails").try(:[], "small").try(:[], "height")

      large_thumbnail_url = image.try(:[], "thumbnails").try(:[], "large").try(:[], "url")
      large_thumbnail_width = image.try(:[], "thumbnails").try(:[], "large").try(:[], "width")
      large_thumbnail_height = image.try(:[], "thumbnails").try(:[], "large").try(:[], "height")

  Image.create!(
    "at_image_id" => at_image_id,
    "url" => url,
    "filename" => filename,
    "size" => size,
    "image_type" => image_type,
    "image_category" => "satellite image",
    "small_thumbnail_url" => small_thumbnail_url,
    "small_thumbnail_width" => small_thumbnail_width,
    "small_thumbnail_height" => small_thumbnail_height,
    "large_thumbnail_url" => large_thumbnail_url,
    "large_thumbnail_width" => large_thumbnail_width,
    "large_thumbnail_height" => large_thumbnail_height,
    "at_locations_table_id" => at_locations_table_id
  )
end
end

      Location.create!(
        "at_locations_table_id" => at_locations_table_id,
        "location_id" => location_id,
        "primary_site_name" => primary_site_name,
        "slug" => slug,
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
end
