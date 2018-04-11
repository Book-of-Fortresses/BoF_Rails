class LocationsController < ApplicationController
  before_action :set_location, only: [:show]

  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
    js :collaborator => Collaborator.find_by(at_collaborator_id: @location.at_collaborator_id).name


    if @location.images.detect{|i| i.image_category == "plan"}
    js :plan_url => @location.images.detect{|i| i.image_category == "plan"}.url
    else
    js :plan_url => asset_path("plan_unavailable.png")
    end





    js :images => @location.images.select{|i| i.image_category != "plan"}.sort_by{|i| i.image_category}


    render :show
  end

  # # GET /locations/new
  # def new
  #   @location = Location.new
  # end
  #
  # # GET /locations/1/edit
  # def edit
  # end
  #
  # # POST /locations
  # # POST /locations.json
  # def create
  #   @location = Location.new(location_params)
  #
  #   respond_to do |format|
  #     if @location.save
  #       format.html { redirect_to @location, notice: 'Location was successfully created.' }
  #       format.json { render :show, status: :created, location: @location }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @location.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # PATCH/PUT /locations/1
  # # PATCH/PUT /locations/1.json
  # def update
  #   respond_to do |format|
  #     if @location.update(location_params)
  #       format.html { redirect_to @location, notice: 'Location was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @location }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @location.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  #
  # # DELETE /locations/1
  # # DELETE /locations/1.json
  # def destroy
  #   @location.destroy
  #   respond_to do |format|
  #     format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

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
