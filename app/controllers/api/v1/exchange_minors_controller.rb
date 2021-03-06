class Api::V1::ExchangeMinorsController < ApplicationController

  def index
    exchange_minors_data = []
    filters_exchange_minors = []

    if user_signed_in?
      puts "USER IS SIGNED IN SOMEHOW"

      # session

      # if profile.filters.any?
      #   filter = profile.filters.first
      #   # puts(filter.to_json)
      #   exchange_minors.each do |exchange_minor|
      #     # puts(exchange_minor.minor.city_id)
      #     # puts(exchange_minor.minor.start_year)
      #     if exchange_minor.minor.city_id == filter.city_id and exchange_minor.minor.start_year == (filter.year + 1)
      #       filters_exchange_minors.push(exchange_minor)
      #     end
      #    end
      # else
      #   filters_exchange_minors = exchange_minors
      # end
    else
      # guest session

      guest = Guest.find_or_create_by!(token: form_authenticity_token)

      if guest.filter
        # filters = guest.filter
        exchange_minors = ExchangeMinor.first
      else
        # filters = {
        #   city_id: default_city.id,
        #   year: default_year
        # }

        exchange_minors = ExchangeMinor.all
      end

      # exchange_minors = ExchangeMinor.all
    end

    exchange_minors.each do |exchange_minor|
      if exchange_minor.profile.published
        data = exchange_minor.card_index
        data[:url] = api_v1_exchange_minor_url(exchange_minor)
        exchange_minors_data << data
      end
    end

    render json: { exchange_minors: exchange_minors_data, authenticity_token: guest.token}
  end

  def show
    exchange_minor = ExchangeMinor.find(params[:id])
    exchange_minor_data = exchange_minor.card_show

    render json: exchange_minor_data
  end
end
