module LocationsHelper
  def images
    Image.where(:at_locations_table_id => @Location.at_locations_table_id)
  end
end
