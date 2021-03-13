class Api::V1::LoginController < Api::V1::ApplicationController
  before_action :getUser, only: [:index]

  # def create
  #   @user = User.create!(email: params[:email], password: 'testtest', password_confirmation: 'testtest')
  #   puts @user
  # end
  #
  # def index
  #   @code = rand(1000..9999)
  #   page_data = {email: @user.email, code: @code}
  #   puts @email
  #
  #   render json: page_data
  # end
  #
  # def getUser
  #   @user = User.last
  # end

  def guest
    device_token = params[:device_token] ? params[:device_token] : SecureRandom.uuid
    guest = Guest.find_by(device_token: device_token)

    unless guest
      filter = Filter.create(profile_id: nil, city_id: nil, year: nil)

      guest = Guest.create(
        device_token: device_token,
        authenticity_token: form_authenticity_token,
        filter_id: filter.id
      )
    end

    render json: {
      tokens: {
        device_token: guest.device_token,
        authenticity_token: guest.authenticity_token,
      },
      filters: {
        cities: City.all.map { |city| city.as_json },
        years: [2, 3],
        city: filter.city_id ? filter.city_id : City.first.id,
        year: filter.year ? filter.year : 2
      }
    }
  end
end
