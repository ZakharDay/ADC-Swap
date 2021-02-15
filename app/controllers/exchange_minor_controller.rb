class ExchangeMinorController < ApplicationController
  before_action :set_exchange_minor, only: [:show]

  def index
  end

  def show
    @master_of_minor = Profile.find(@exchange_minor.profile_id)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exchange_minor
      @exchange_minor = ExchangeMinor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    # def brand_params
    #   params.require(:brand).permit(:name, :description, :site, :logo)
    # end
end
