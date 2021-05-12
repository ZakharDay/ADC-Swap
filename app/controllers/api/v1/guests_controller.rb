class Api::V1::GuestsController < Api::V1::ApplicationController
  skip_before_action :verify_authenticity_token, only: [:new, :create]

  def index
    render json: {auth:false}
  end
end
