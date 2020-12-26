class Api::V1::MinorsController < ApplicationController
  def index
    minors = Minor.all

    minors_data = []

    # minors.each do |minor|
    #   data = minor.card_index
    #   # data[:url] = api_v1_exchange_minor_url(exchange_minor)
    #   exchange_minors_data << data
    # end

    render json: minors
  end

  # def show
  #   exchange_minor = ExchangeMinor.find(params[:id])
  #   exchange_minor_data = exchange_minor.card_show
  #
  #   render json: exchange_minor_data
  # end
end
