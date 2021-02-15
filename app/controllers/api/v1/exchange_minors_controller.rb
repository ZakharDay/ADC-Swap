class Api::V1::ExchangeMinorsController < ApplicationController
  def index
    exchange_minors = ExchangeMinor.all

    exchange_minors_data = []

    exchange_minors.each do |exchange_minor|
      if exchange_minor.profile.published
        data = exchange_minor.card_index
        data[:url] = api_v1_exchange_minor_url(exchange_minor)
        exchange_minors_data << data
      end
    end

    render json: exchange_minors_data
  end

  def show
    exchange_minor = ExchangeMinor.find(params[:id])
    exchange_minor_data = exchange_minor.card_show

    render json: exchange_minor_data
  end
end
