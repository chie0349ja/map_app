class SpotsController < ApplicationController
  before_action :set_spot, only: %i[ show edit update destroy ]

  # GET /spots
  def index
    @spots = Spot.all.order("created_at DESC")
  end

  # GET /spots/1
  def show
  end

  # GET /spots/new
  def new
    @spot = Spot.new
  end

  # GET /spots/1/edit
  def edit
  end

  # POST /spots
  def create
    @spot = Spot.new(spot_params)

    unless @spot.photo.attached?
      @spot.photo.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'image.png')), filename: 'image.png', content_type: 'image/png')
    end

    if @spot.save
      redirect_to @spot, notice: "Spot was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /spots/1
  def update
    if @spot.update(spot_params)
      redirect_to @spot, notice: "Spot was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /spots/1
  def destroy
    @spot.destroy
    redirect_to spots_url, notice: "Spot was successfully destroyed.", status: :see_other
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def spot_params
      params.require(:spot).permit(:lat, :lng, :name, :photo, :category_id, :value, :spots_url)
    end

end
