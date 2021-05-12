class Api::V1::ExchangeMinorsController < Api::V1::ApplicationController

  def index
    puts 'TOKENS FROM IOS APP'
    puts params[:authenticity_token]
    puts 'TOKENS FROM IOS APP'

    exchange_minors = ExchangeMinor.all
    exchange_minors_data = []
    filtered_exchange_minors = []

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

      exchange_minors.each do |exchange_minor|
        filtered_exchange_minors << exchange_minor
      end
    end


    exchange_minors.each do |exchange_minor|
      # TODO Почему published — настройка профиля, а не exchange_minor?
      if exchange_minor.profile.published
        data = exchange_minor.card_index
        data[:url] = api_v1_exchange_minor_url(exchange_minor)
        exchange_minors_data << data
      end
    end

    render json: {
      exchange_minors: exchange_minors_data
    }
  end

  def show
    exchange_minor = ExchangeMinor.find(params[:id])
    exchange_minor_data = exchange_minor.card_show

    render json: exchange_minor_data
  end
end
