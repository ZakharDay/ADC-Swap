class Api::V1::ExchangeRequestsController < ApplicationController
  def create
    render json: {
      success: "Exchange Request just created",
      status: 200
    }, status: 200
  end
end
