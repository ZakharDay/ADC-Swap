class Api::V1::LoginController < ApplicationController
  before_action :getUser, only: [:index]

  def create
    @user = User.create!(email: params[:email], password: 'testtest', password_confirmation: 'testtest')
    puts @user
  end

  def index
    @code = rand(1000..9999)
    page_data = {email: @user.email, code: @code}
    puts @email

    render json: page_data
  end

  def getUser
    @user = User.last
  end

  def guest
    token = params[:devise_token] ? params[:devise_token] : SecureRandom.uuid

    puts 'TOKEN'
    puts params[:devise_token]
    puts token

    guest = Guest.find_or_create_by!(token: token)

    render json: {
      devise_token: guest.token,
      authenticity_token: form_authenticity_token
    }
  end
end
