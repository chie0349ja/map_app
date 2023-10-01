class SpotsController < ApplicationController
  
  before_action :set_spot, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, only: [:new, :edit, :update,:destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :move_to_index, except: [:index, :show]

  # GET /spots
  def index
    @q = Spot.ransack(params[:q])

    if params[:q] && (params[:q][name_cont].present? || params[:q][:category].present?)
      @spots = @q.result(distinct: true).includes(:user).order("created_at DESC")
    else
      @spots = Spot.includes(:user).order("created_at DESC")
    end

    respond_to do |format|
      format.html
      format.json
    end
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

  def search
    @q = Spot.ransack(params[:q])
    @spots = @q.result.includes(:user).order("created_at DESC")
    render 'index'
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      #@spot = Spot.find(params[:id])
      @spot = Spot.find_by(id: params[:id])
      unless @spot
        flash[:error] = "Spot not found"
        redirect_to spot_path
      end
    end

    # Only allow a list of trusted parameters through.
    def spot_params
      params.require(:spot).permit(:lat, :lng, :name, :photo, :category_id, :value, :spots_url).merge(user_id: current_user.id)
    end

    def move_to_index
      unless user_signed_in?
        redirect_to action: :index
      end
    end

    def authorize_user!
      unless @spot.user == current_user
        flash[:alert] = "You don't have permission to edit this spot."
        redirect_to root_path
      end
    end

end
