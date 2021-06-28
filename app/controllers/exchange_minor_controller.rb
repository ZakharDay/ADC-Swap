class ExchangeMinorController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exchange_minor, only: [:show, :destroy]

  def index
  end

  def show
    @master_of_minor = Profile.find(@exchange_minor.profile_id)
  end

  def destroy
    ArchivedExchange.create!(profile_id: @exchange_minor.profile_id, minor_id:@exchange_minor.minor_id)
    @exchange_minor.destroy
    # respond_to do |format|
      # format.html { redirect_to exchange_requests_path(current_user.profile.id), notice: 'Request was successfully destroyed.' }
      # format.json { head :no_content }
    # end
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
