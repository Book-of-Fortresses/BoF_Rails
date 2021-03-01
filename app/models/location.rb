class Location < ApplicationRecord
  has_many :perspective_drawings, :foreign_key => 'at_locations_table_id', :primary_key => 'at_locations_table_id'

  has_many :images, :foreign_key => 'at_locations_table_id',
  :primary_key => 'at_locations_table_id'

  def to_param
    slug
  end

  def collaborator_names
    collaborators.map(&:name).join(', ')
  end

  def collaborator_ids
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

  def plan_url
    plan_image ? plan_image.url : ActionController::Base.helpers.asset_path('location/plan_unavailable.png')
  end

end
