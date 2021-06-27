class WelcomeController < ApplicationController
  layout "registration"
  def index
    if user_signed_in?
      @user = current_user
    else
      @user = User.new
    end
  end

  def auth
    email = params[:user][:email]
    user = User.find_by_email(email)
    code = [rand(0..9), rand(0..9), rand(0..9), rand(0..9)].shuffle.join('')

    if user
      user.update_attribute(:password, code)
      UserLoginCodeMailer.with(email: user.email, code: code).login_code_email.deliver_now
    else
      guest = Guest.create!(email: email, code: code)
      UserLoginCodeMailer.with(email: email, code: code).login_code_email.deliver_now
    end
  end
end
