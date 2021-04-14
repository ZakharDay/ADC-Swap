class Api::V1::MinorsController < Api::V1::ApplicationController
  def index
      profile = Profile.first
      cities = City.all
      page_data = []

      filters_minors = []

      if profile.filters.count > 0
        filter = profile.filters.first
        puts(filter.to_json)
        cities.each do |city|
          if filter.city_id == city.id
            city_name = city.name
            minors = city.minors
            minors_data = []
            minors.each do |minor|
              if minor.start_year == (filter.year + 1)
                minors_data.push({name: minor.name, id: minor.id, year: minor.start_year, address: minor.address, credits:minor.credits, url: api_v1_minor_url(minor.id)})
              end
            end
            data = {city: city_name, minors:minors_data}
            page_data << data

          end
         end
      else
        cities.each do |city|
            city_name = city.name
            minors = city.minors

            minors_data = []
            minors.each do |minor|
              minors_data.push({name: minor.name, id: minor.id, year: minor.start_year, address: minor.address, credits:minor.credits, url: api_v1_minor_url(minor.id)})
            end

            data = {city: city_name, minors:minors_data}
            # data[:url] = api_v1_exchange_minor_url(exchange_minor)
            page_data << data
        end
      end

    render json: page_data
  end

  def show
    minor = Minor.find(params[:id])

    minor_data = {name: minor.name,
    credits: minor.credits,
    adress: minor.address,
    responsible: minor.responsible,
    responsibleForTheMinor: minor.name,
    minorDescription: minor.description,
    minorUrl: minor.url}

    render json: minor_data
  end
end
