module LocationsHelper

  def secondary_sites(location)
    ss = []
    location.images.each do |image|
      if image.secondary_site_name
        unless image.secondary_site_name == 'None'
          ss << image.secondary_site_name.split(',')
        end
      end
    end
    ss = ss.flatten.map{|i| i.strip}.uniq.join(', ')
  end

end
