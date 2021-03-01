module LocationsHelper

  # index
  def sorted_locations
    @locations.sort_by{|location| location.itinerary_order.to_i}
  end

  def featured_icon(location)
    return blank_icon unless location.stage.include? 'Prototype Site'

    image_tag "locations/icons/font_awesome/PNG/star-solid.png", title: 'Featured Site'
  end

  def landscape_icon(location)
    return blank_icon unless location.stage.include? 'Virtual Landscape Begun'

    image_tag "locations/icons/font_awesome/PNG/mountain-solid.png", title: 'Virtual Landscape'
  end

  def model_icon(location)
    return blank_icon unless location.stage.include? '3D Modeling Begun'

    image_tag "locations/icons/font_awesome/PNG/cube-solid.png", title: '3D Model'
  end

  def views_icon(location)
    return blank_icon unless location.stage.include? '3D Views Added to ArcGIS'

    image_tag "locations/icons/font_awesome/PNG/images-solid.png", title: '3D Views'
  end

  def photogrammetry_icon(location)
    return blank_icon unless location.stage.include? 'Photogrammetry Begun'

    image_tag "locations/icons/font_awesome/PNG/camera-solid.png", title: 'Photogrammetry'
  end

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

end
