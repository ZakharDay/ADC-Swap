class Api::V1::ExchangeMinorsController < ApplicationController
  def index
    exchange_minors = ExchangeMinor.all
    exchange_minors_data = exchange_minors.map { |e| e.card }

    render json: exchange_minors_data
  end
end
