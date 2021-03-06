class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def default_city
    City.find_by_name('Москва')
  end

  def default_year
    (Date.today>>1).strftime("%Y").to_s.to_i - 1
  end
end
