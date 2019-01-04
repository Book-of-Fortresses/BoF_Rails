class LocationsController < ApplicationController
  helper LocationsHelper
  before_action :set_location, only: [:show]

  def index
    @locations = Location.all
  end

  def show
    @locations = Location.all
    # Pass parameters to locations_show_view.js.erb
    js :images => @location.images.select{|i| i.image_category != "plan"}.sort_by{|i| i.image_category}
    if @location.at_collaborator_id
      collaborator_ids = @location.at_collaborator_id.split(',')
      collaborators = []
      collaborator_ids.each do |id|
        collaborators << Collaborator.find_by(at_collaborator_id: id).name
      end
      js :collaborator => collaborators.join(', ')
    end
    if @location.images.detect{|i| i.image_category == "plan"}
      js :plan_url => @location.images.detect{|i| i.image_category == "plan"}.url
    else
      js :plan_url => ActionController::Base.helpers.asset_path('location/plan_unavailable.png')
    end

    render :show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = Location.find_by(slug: params[:slug])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.fetch(:location, {})
    end
end
