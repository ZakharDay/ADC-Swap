class ExchangeMinorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exchange_request, only: [:show, :changeStatus, :update, :destroy]

  def index
    @exchange_minors = ExchangeMinor.all
  end

  def show
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
    def set_exchange_request
      @exchange_minor = ExchangeMinor.find(params[:id])
    end
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def exchange_minor_params
      params.require(:exchange_minor).permit(:minor_id, :published)
    end
end
