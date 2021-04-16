class FiltersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_filter, only: [:update]

  def new
  end

  def index
    @newfilter = Filter.new

    if Profile.find(current_user.id).filters.count > 0
      @filter = Filter.find(Profile.find(current_user.id).filters.first.id)
    end
  end

  def show
    @filter = Filter.find(params[:id])
  end

  def create
    year_now =  ((Date.today>>1).strftime("%Y").to_s.to_i) - params[:filter][:year].to_i
    Filter.create!(profile_id: params[:filter][:profile_id], city_id:params[:filter][:city_id], year: year_now)
  end

  def update
    respond_to do |format|
      # @filter.update(filter_params)
      year_now =  ((Date.today>>1).strftime("%Y").to_s.to_i) - params[:filter][:year].to_i
      if @filter.update(profile_id: params[:filter][:profile_id], year: year_now, city_id: params[:filter][:city_id])
        format.html { redirect_to welcome_index_path, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @filter }
      else
        format.html { render :edit }
        format.json { render json: @filter.errors, status: :unprocessable_entity }
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_filter
      @filter = Filter.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:filter).permit(:profile_id, :year, :city_id)
    end
end
