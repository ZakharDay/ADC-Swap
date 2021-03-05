class Api::V1::ExchangeMinorsController < ApplicationController
  def index
    profile = Profile.first
    exchange_minors_data = []
    exchange_minors = ExchangeMinor.all
    filters_exchange_minors = []

    if profile.filters.count > 0
      filter = profile.filters.first
      puts(filter.to_json)
      exchange_minors.each do |exchange_minor|
        puts(exchange_minor.minor.city_id)
        puts(exchange_minor.minor.start_year)
        if exchange_minor.minor.city_id == filter.city_id and exchange_minor.minor.start_year == (filter.year + 1)
          filters_exchange_minors.push(exchange_minor)
        end
       end
    else
      filters_exchange_minors = exchange_minors
    end
    filters_exchange_minors.each do |exchange_minor|
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
