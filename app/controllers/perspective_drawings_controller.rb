class PerspectiveDrawingsController < ApplicationController
  before_action :set_perspective_drawing, only: [:show, :edit, :update, :destroy]

  # GET /perspective_drawings
  # GET /perspective_drawings.json
  def index
    @perspective_drawings = PerspectiveDrawing.all
  end

  # GET /perspective_drawings/1
  # GET /perspective_drawings/1.json
  def show
  end

  # GET /perspective_drawings/new
  def new
    @perspective_drawing = PerspectiveDrawing.new
  end

  # GET /perspective_drawings/1/edit
  def edit
  end

  # POST /perspective_drawings
  # POST /perspective_drawings.json
  def create
    @perspective_drawing = PerspectiveDrawing.new(perspective_drawing_params)

    respond_to do |format|
      if @perspective_drawing.save
        format.html { redirect_to @perspective_drawing, notice: 'Perspective drawing was successfully created.' }
        format.json { render :show, status: :created, location: @perspective_drawing }
      else
        format.html { render :new }
        format.json { render json: @perspective_drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /perspective_drawings/1
  # PATCH/PUT /perspective_drawings/1.json
  def update
    respond_to do |format|
      if @perspective_drawing.update(perspective_drawing_params)
        format.html { redirect_to @perspective_drawing, notice: 'Perspective drawing was successfully updated.' }
        format.json { render :show, status: :ok, location: @perspective_drawing }
      else
        format.html { render :edit }
        format.json { render json: @perspective_drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /perspective_drawings/1
  # DELETE /perspective_drawings/1.json
  def destroy
    @perspective_drawing.destroy
    respond_to do |format|
      format.html { redirect_to perspective_drawings_url, notice: 'Perspective drawing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_perspective_drawing
      @perspective_drawing = PerspectiveDrawing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def perspective_drawing_params
      params.fetch(:perspective_drawing, {})
    end
end
