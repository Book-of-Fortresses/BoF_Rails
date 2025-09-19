module LocationsHelper

  # index
  def sorted_locations
    @locations.sort_by{|location| location.itinerary_order.to_i}
  end

  # Featured Site
  def featured_site_text
    'Featured Site'
  end

  def star_icon
    image_tag "locations/icons/font_awesome/PNG/star-solid.png", title: 'star icon'
  end

  def featured_icon(location)
    return blank_icon unless location&.stage&.include? featured_site_text

    star_icon
  end

  # 3D Model
  def model_text
    'Fusion360 Model'
  end
  def cube_icon
    image_tag "locations/icons/font_awesome/PNG/cube-solid.png", title: 'cube icon'
  end

  def model_icon(location)
    return blank_icon unless location&.stage&.include? model_text

    cube_icon
  end

  # Drone Photogrammetry
  def drone_text
   'Drone Photogrammetry'
  end

  def copter_icon
    image_tag "locations/icons/font_awesome/PNG/helicopter.png", title: 'helicopter icon'
  end

  def drone_icon(location)
    return blank_icon unless location&.stage&.include? drone_text

    copter_icon
  end

  # LIDAR Data
  def lidar_text
   'LIDAR'
  end

  def laser_icon
    image_tag "locations/icons/font_awesome/PNG/laser.png", title: 'laser icon'
  end

  def lidar_icon(location)
    return blank_icon unless location&.stage&.include? lidar_text

    laser_icon
  end

  # Views
  def views_text
    '3D Views Added to ArcGIS'
  end

  def globe_icon
    image_tag "locations/icons/font_awesome/PNG/globe.png", title: 'globe icon'
  end

  def views_icon(location)
    return blank_icon unless location&.stage&.include? views_text

    globe_icon
  end

  # Photographs
  def photographed_text
    'Photographed'
  end

  def camera_icon
    image_tag "locations/icons/font_awesome/PNG/retro-camera.png", title: 'camera icon'
  end

  def photographed_icon(location)
    return blank_icon unless location&.stage&.include? photographed_text

    camera_icon
  end

  # Blank filler icon
  def blank_icon
    image_tag "locations/icons/font_awesome/PNG/blank.png"
  end

  # show
  def previous_location_arrow
    location = @location.previous_location
    link = location ? location : locations_path
    link_to location do
      image_tag asset_path 'location/arrow_left.png'
    end
  end

  def following_location_arrow
    location = @location.following_location
    link = location ? location : locations_path
    link_to link do
      image_tag asset_path 'location/arrow_right.png'
    end
  end

  def previous_location_name
    previous_location = @location.previous_location
    if previous_location
      link_to previous_location.primary_site_name, previous_location
    else
      link_to 'Locations', locations_path
    end
  end

  def following_location_name
    following_location = @location.following_location
    if following_location
      link_to following_location.primary_site_name, following_location
    else
      link_to 'Locations', locations_path
    end
  end

  def formatted_secondary_sites
    @location.secondary_sites.join(', ')
  end

  def location_plan
    if @location.plan_image
      image_tag(@location.plan_image.url)
    else
      image_tag('location/plan_unavailable.png')
    end
  end

  def location_3d_model
    image_tag('location/3d_model.png', height: 'auto', width: '200')
  end

  def image_source(image)
    case image.source
    when '1642_watercolor'
      '1642 Watercolor'
    else
      image.source
    end
  end

  def event_sources?
    (@location.fortalezas_link.present? || @location.castillosnet_link.present? || @location.wikipedia_link.present?)
  end

  # def event_sources
  #    [ (link_to 'Fortalezas.org', @location.fortalezas_link, target: :_blank), (link_to 'Castillos.net', @location.castillosnet_link, target: :_blank), (link_to 'Wikipedia', @location.wikipedia_link, target: :_blank) ]
  # end

  def event_sources_text
    fortalezas = link_to 'Fortalezas.org', @location.fortalezas_link, target: :_blank
    castillos = link_to 'Castillos.net', @location.castillosnet_link, target: :_blank
    wikipedia = link_to 'Wikipedia', @location.wikipedia_link, target: :_blank

    sources = []
    if @location.fortalezas_link.present?
      sources << fortalezas
    end
    if @location.castillosnet_link.present?
      sources << castillos
    end
    if @location.wikipedia_link.present?
      sources << wikipedia
    end
    sources
  end

  def image_display(image)
    if image.id == @location.default_viewer_id
      ""
    else
      "display:none;"
    end
  end

  def right_display(image)
    if image.id == @location.default_right_viewer_id
      ""
    else
      "display:none;"
    end
  end

  def image_title(image)
    title = ""
    if image.source
      title.concat(image.formatted_source)
    end
    if image.view_direction
       title.concat(" - #{image.view_direction}")
    elsif image.image_category == "plan"
      title.concat(" Plan")
    end
    if image.image_category == "satellite image"
      title.concat(" Satellite Image")
    end
    title.strip
  end

  def select_image_title(image)
    title = ""
    if image.source
      title.concat(image.formatted_source)
    end
    if image.image_category == "plan"
      title.concat(" Plan")
    elsif image.view_direction
      unless image.image_category == "plan"
        title.concat(" view: #{image.view_direction}")
      end
    end
    title.strip
  end

end
