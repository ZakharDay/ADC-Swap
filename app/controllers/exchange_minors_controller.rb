class ExchangeMinorsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @exchange_minors = ExchangeMinor.all
  end

  def show
    @exchange_minor = ExchangeMinor.find(params[:id])
  end
end
