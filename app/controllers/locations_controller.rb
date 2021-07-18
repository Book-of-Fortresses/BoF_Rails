class LocationsController < ApplicationController
  helper LocationsHelper
  before_action :find_location, only: [:show]

  def index
    @locations = Location.all
  end

  def show
    # Pass parameters to locations_show_view.js.erb
    js :images => @location.images_excluding_plan
    js :collaborator => @location.collaborator_names
    js :plan_url => @location.plan_url
  end

  private

    def find_location
      @location = Location.find_by(slug: params[:slug])
    end

    def location_params
      params.fetch(:location, {})
    end
end
