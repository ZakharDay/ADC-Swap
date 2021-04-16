class UserLoginCodeMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def login_code_email
    @email = params[:email]
    @code = params[:code]
    mail(to: @email, subject: 'Login code')
  end
end
