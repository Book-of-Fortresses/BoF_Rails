class Image < ApplicationRecord
  belongs_to :location, :foreign_key => 'at_locations_table_id', :primary_key => 'at_locations_table_id', optional: true

  def title
    title = ""
    if source
      title.concat(formatted_source)
    end
    if view_direction
       title.concat(", view: #{view_direction}")
    end
    if image_category == "satellite image"
      title.concat(" Satellite Image")
    end
    if image_category == "plan"
      title.concat(" Plan")
    end
    title.strip
  end

  def formatted_source
    case source
    when "1642_watercolor"
      "1642 Watercolor"
    else
      source
    end
  end
end
