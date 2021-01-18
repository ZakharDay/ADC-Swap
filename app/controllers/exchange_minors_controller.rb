class ExchangeMinorsController < ApplicationController
  def index
    @exchange_minors = ExchangeMinor.all
  end

  def show
    @exchange_minor = ExchangeMinor.find(params[:id])
  end
end
