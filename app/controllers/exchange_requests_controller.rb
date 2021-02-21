class ExchangeRequestsController < ApplicationController
  before_action :set_exchange_request, only: [:show, :changeStatus, :update]

  def index
  end

  def show
    @message = Message.new
  end

  def create
    @exchange_request = ExchangeRequest.create!(
      requester_id: current_user.id,
      requester_minor_id: current_user.profile.minor_id,
      responder_id: params[:id_master_of_minor],
      responder_minor_id: params[:exchange_minor_id],
      exchange_minor_id: current_user.profile.minor_id,
      # approved_by_responder: null,
    )

    respond_to do |format|
      if @exchange_request.save
        format.html { redirect_to exchange_minor_path(params[:exchange_minor_id])}
        format.json { render :show, status: :created, location: @exchange_request }
      else
        format.html { render :new }
        format.json { render json: @exchange_request.errors, status: :unprocessable_entity }
      end
    end

  end

  def update

    respond_to do |format|
      if @exchange_request.update(approved_by_responder: params[:approved])
        format.html { redirect_to profile_exchange_requests_path,  notice: 'Exchange request was successfully updated.' }
        format.json { render :show, status: :ok, location: @exchange_request }
      else
        format.html { render :edit }
        format.json { render json: @exchange_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def set_exchange_request
    @exchange_request = ExchangeRequest.find(params[:id])
  end

end
