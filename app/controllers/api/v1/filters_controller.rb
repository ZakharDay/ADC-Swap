class Api::V1::FiltersController < Api::V1::ApplicationController

  # def index
  #   filters_data = {}
  #   all_cities = []
  #   page_data = {}
  #
  #   City.all.each do  |city|
  #     all_cities.push({city_name: city.name, city_id: city.id})
  #   end
  #
  #   if user_signed_in?
  #     # find session, find profile
  #
  #     if profile.filters.any?
  #       filters_data = {
  #         profile_id: profile.id,
  #         url: api_v1_filters_url,
  #         action: 'create'
  #       }
  #     else
  #       filter = profile.filters.first
  #       filters_data = {
  #         profile_id: profile.id,
  #         city_name: City.find(filter.city_id).name,
  #         city_id: City.find(filter.city_id).id,
  #         year: ((Date.today>>1).strftime("%Y").to_s.to_i) - filter.year.to_i,
  #         url: api_v1_filters_url,
  #         action: 'update'
  #       }
  #     end
  #   else
  #     filters_data = {
  #       city_name: default_city.name,
  #       city_id: default_city.id,
  #       year: default_year,
  #       url: api_v1_filters_url,
  #       action: 'update'
  #     }
  #   end
  #
  #   page_data = {
  #     all_cities: all_cities,
  #     filters_data: filters_data,
  #     authenticity_token: form_authenticity_token
  #   }
  #
  #   render json: page_data
  # end

  # TODO Надо переименовать в update
  def create
    # profile_id = params[:filters_data][:profile_id]
    # city_id = params[:filters_data][:city_id]
    # year = params[:filters_data][:year]
    # action = params[:action]

    # profile_id = 1
    # city_id = 1
    # year = 2019
    # action = "create"
    #
    # year_now = ((Date.today>>1).strftime("%Y").to_s.to_i) - year.to_i

    if user_signed_in?
      # if action == "create"
      #   filter = Filter.create!(profile_id: profile_id, city_id: city_id, year: year_now)
      # elsif action == "update"
      #   filter = Profile.find(profile_id).filters.first
      #   filter.update!(profile_id: profile_id, year: year_now, city_id: city_id)
      # end
    else
      exchange_minors = ExchangeMinor.all
      exchange_minors_data = []
      filtered_exchange_minors = []

      guest = Guest.find_by(device_token: params[:device_token])
      filter = guest.filter

      filter.update({
        city_id: params[:filter][:city_id],
        year: params[:filter][:year]
      })

      if filter.city_id != nil
        exchange_minors.each do |exchange_minor|
          if exchange_minor.minor.city_id == filter.city_id && exchange_minor.minor.start_year == (filter.year + 1)
            filtered_exchange_minors << exchange_minor
          end
        end
      else
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

      authenticity_token = update_guest_auth_token_and_return(guest)

      render json: {
        tokens: {
          authenticity_token: authenticity_token
        },
        exchange_minors: exchange_minors_data
      }
    end
  end

  private

  def update_guest_auth_token_and_return(guest)
    authenticity_token = form_authenticity_token
    guest.authenticity_token = authenticity_token
    guest.save!

    authenticity_token
  end

end
