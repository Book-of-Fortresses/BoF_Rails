class ImagesController < ApplicationController
  before_action :set_image, only: [:show, :edit, :update, :destroy]

  def index
    @images = Image.all
  end

  def show
    render :show
  end

  def create
    @image = Image.new(image_params)
  end

  private
    def set_image
      @image = Image.find_by(slug: params[:slug])
    end

    def image_params
      params.permit(:at_image_id, :slug, :at_images_table_id, :at_locations_table_id, :url, :filename, :size, :image_type, :image_category, :source, :page_number, :primary_site_name, :view_direction, :secondary_site_name, :secondary_site_kingdom, :number_of_watchtowers, :exterior_features, :status, :fortress_features, :agol_slide_embed, :at_images_table_time_created, :small_thumbnail_url, :small_thumbnail_width, :small_thumbnail_height, :large_thumbnail_url, :large_thumbnail_width, :large_thumbnail_height)
    end
end
