class Location < ApplicationRecord
  has_many :perspective_drawings, :foreign_key => 'at_locations_table_id', :primary_key => 'at_locations_table_id'

  has_many :images, :foreign_key => 'at_locations_table_id',
  :primary_key => 'at_locations_table_id'

  has_many :events, :foreign_key => 'at_location_id', :primary_key => 'at_locations_table_id'

  def to_param
    slug
  end

  def collaborator_names
    collaborators.map(&:name).join(', ')
  end

  def model_collaborators
    brittany = Collaborator.where(name: "Brittany Forniotis")
    modelers = collaborators - brittany
    modelers.map(&:name).join(", ")
  end

  # ex at_collaborator_id: "usr6jZBvB6JA46dMe,usrdrMXLmfCGRX390,usrRiFLmaKkNIn2E2"
  def collaborator_ids
    return [] if at_collaborator_id.blank?
    at_collaborator_id.split(',')
  end

  def collaborators
    Collaborator.where(at_collaborator_id: collaborator_ids)
  end

  def previous_location
    previous_itinerary_order = itinerary_order - 1
    Location.find_by(itinerary_order: previous_itinerary_order)
  end

  def following_location
    following_itinerary_order = itinerary_order + 1
    Location.find_by(itinerary_order: following_itinerary_order)
  end

  # other locations that appear in the location's images
  def secondary_sites
    sites = images.each_with_object([]) do |image, sites|
      if image.secondary_site_name && image.secondary_site_name != 'None'
        sites << image.secondary_site_name.split(',')
      end
    end
    sites.flatten.map{ |site| site.strip }.uniq
  end

  def plan_image
    images.detect{ |image| image.image_category == "plan" }
  end

  def images_excluding_plan
    images.select{ |image| image.image_category != "plan" }.sort_by{|image| image.image_category}
  end

  def images_excluding_satellite
    images.select{ |image| image.image_category != "satellite image" }
  end

  def plan_url
    plan_image ? plan_image.url : ActionController::Base.helpers.asset_path('location/plan_unavailable.png')
  end

  def transfer_events
    events.select{|e| e.transfer? }.sort_by{|e| (e.order || 0)}
  end

  def building_events
    events.select{|e| e.building? }.sort_by{|e| (e.order || 0)}
  end

  def military_events
    events.select{|e| e.military? }.sort_by{|e| (e.order || 0)}
  end

  def charter_events
    events.select{|e| e.charter? }.sort_by{|e| (e.order || 0)}
  end

  def default_viewer_id
    images_excluding_satellite.detect{|i| (i.image_category != "plan" && i.agol_slide_embed.present?) }.id
  end
end
