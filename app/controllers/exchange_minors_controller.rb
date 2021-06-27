class ExchangeMinorsController < ApplicationController
  before_action :authenticate_user!

  def index
    @exchange_minors = ExchangeMinor.all
  end

  def show
    @exchange_minor = ExchangeMinor.find(params[:id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.

    # Only allow a list of trusted parameters through.
    def exchange_minor_params
      params.require(:exchange_minor).permit(:minor_id, :published)
    end
end
