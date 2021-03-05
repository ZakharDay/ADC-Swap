class Api::V1::FiltersController < ApplicationController
  def create
    p = params[:data]

    year_now =  ((Date.today>>1).strftime("%Y").to_s.to_i) - p[:filters_data][:year]

    if p[:action] == "create"

      Filter.create!(profile_id: p[:filters_data][:profile_id], city_id:p[:filters_data][:city_id], year: year_now)
    elsif p[:action] == "update"
      f = Profile.find(p[:filters_data][:profile_id]).filters.first
      f.update!(profile_id: p[:filters_data][:profile_id], year: year_now, city_id: p[:filters_data][:city_id])
    end

    # mes = Message.create!(exchange_request_id:params[:message][:exchange_request_id], profile_id:params[:message][:profile_id], content:params[:message][:content])
    #
    # SentMessageJob.perform_later(mes)
  end

  def index
    random_id = rand(Profile.count)+1

    filters_data = {}
    all_cities = []
    page_data = Hash.new

    City.all.each do  |city|
      all_cities.push({city_name: city.name, city_id: city.id})
    end

    if random_id > 2
      random_id = 2
    end

    profile = Profile.find(random_id)

    if profile.filters.count == 0
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
        profile_id: profile.id,
        year: ((Date.today>>1).strftime("%Y").to_s.to_i) - filter.year.to_i,
        url: api_v1_filters_url,
        action: 'update'
      }
    end

    page_data = {all_cities: all_cities, filters_data: filters_data}

    render json: page_data
  end
end
