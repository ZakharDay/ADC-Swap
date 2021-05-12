class Api::V1::ApplicationController < ApplicationController

  def verify_authenticity_token
    # device_token = params[:device_token] ? params[:device_token] : SecureRandom.uuid
    authenticity_token = params[:authenticity_token]
    # guest = Guest.find_by(device_token: device_token)

    if authenticity_token
      # Этот метод запрещает подключение
      # handle_unverified_request

      puts "TOKEN FROM REQUEST"
      puts authenticity_token
      # puts "IS EQUEAL TO GUEST TOKEN"
      # puts guest.authenticity_token
    # elsif guest
      # puts "TOKEN FROM REQUEST"
      # puts authenticity_token
      # puts "IS NOT EQUEAL TO GUEST TOKEN"
      # puts guest.authenticity_token

      handle_unverified_request if request.post?
    end
  end

end
