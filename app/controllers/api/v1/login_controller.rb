class Api::V1::LoginController < Api::V1::ApplicationController
  # before_action :getUser, only: [:index]

  def create
    email =  params[:email]
    result = {email: email}

    if params[:type] == 'email'
      if email.include? "@edu.hse.ru"
        result[:approved] = true
        u = User.find_by_email(email)

        code = [rand(0..9), rand(0..9), rand(0..9), rand(0..9)].shuffle.join('')
        result[:code] = code

        if u
          result[:reg] = false
          u.update_attribute(:password, code)
        else
          u = User.create!(email: email, password: code, password_confirmation: code)
          result[:reg] = true
        end

        render json: result

        UserLoginCodeMailer.with(email: u.email, code: code).login_code_email.deliver_now
      else
        result[:approved] = false
      end
    else if params[:type] == 'verification'
      Session.create!(email: params[])
      # form_for(@user, url: user_session_path, id: 'authCodeForm') do |f|
      #     f.label :email
      #     f.email_field :email, id: "emailField" value: params[:value]
      #
      #     f.label :password
      #     f.password_field :password, autocomplete: "current-password"
      #
      #     f.submit "Log in"
      # end
    end


    # @user = User.create!(email: params[:email], password: 'testtest', password_confirmation: 'testtest')
    # puts @user
    end
  end

  # def index
  #   page_data = {code: code}
  #   render json: page_data
  # end

  # def getUser
  #   @user = User.last
  # end

  def guest
    device_token = params[:device_token] ? params[:device_token] : SecureRandom.uuid
    guest = Guest.find_by(device_token: device_token)

    unless guest

      guest = Guest.create(
        device_token: device_token,
        authenticity_token: form_authenticity_token,
      )
    end

    render json: {
      tokens: {
        device_token: guest.device_token,
        authenticity_token: guest.authenticity_token,
      },
      user_info: {auth: false}
    }
  end
end
