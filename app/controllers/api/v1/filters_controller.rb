class Api::V1::FiltersController < ApplicationController

  def index
    filters_data = {}
    all_cities = []
    page_data = {}

    City.all.each do  |city|
      all_cities.push({city_name: city.name, city_id: city.id})
    end

    if user_signed_in?
      # find session, find profile

      if profile.filters.any?
        filters_data = {
          profile_id: profile.id,
          url: api_v1_filters_url,
          action: 'create'
        }
      else
        filter = profile.filters.first
        filters_data = {
          profile_id: profile.id,
          city_name: City.find(filter.city_id).name,
          city_id: City.find(filter.city_id).id,
          year: ((Date.today>>1).strftime("%Y").to_s.to_i) - filter.year.to_i,
          url: api_v1_filters_url,
          action: 'update'
        }
      end
    else
      filters_data = {
        city_name: default_city.name,
        city_id: default_city.id,
        year: default_year,
        url: api_v1_filters_url,
        action: 'update'
      }
    end

    page_data = {
      all_cities: all_cities,
      filters_data: filters_data,
      authenticity_token: form_authenticity_token
    }

    render json: page_data
  end

  def create
    puts "========"
    puts params
    puts "========"

    profile_id = params[:filters_data][:profile_id]
    city_id = params[:filters_data][:city_id]
    year = params[:filters_data][:year]
    action = params[:action]

    year_now = ((Date.today>>1).strftime("%Y").to_s.to_i) - year.to_i

    if user_signed_in?
      # if action == "create"
      #   filter = Filter.create!(profile_id: profile_id, city_id: city_id, year: year_now)
      # elsif action == "update"
      #   filter = Profile.find(profile_id).filters.first
      #   filter.update!(profile_id: profile_id, year: year_now, city_id: city_id)
      # end
    else
      if action == "create"
        filter = Filter.create!(profile_id: nil, city_id: city_id, year: year_now)
        guest = Guest.find_by_token(params[:authenticity_token])
        guest.filter_id = filter.id
        guest.save!

      # elsif action == "update"
        # filter = Profile.find(profile_id).filters.first
        # filter.update!(profile_id: nil, city_id: city_id, year: year_now)
      end
    end

    # mes = Message.create!(exchange_request_id:params[:message][:exchange_request_id], profile_id:params[:message][:profile_id], content:params[:message][:content])
    #
    # SentMessageJob.perform_later(mes)
  end

end
