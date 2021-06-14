class ExchangeRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exchange_request, only: [:show, :changeStatus, :update, :destroy]

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
      status: 'start'
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

  # def update
  #   respond_to do |format|
  #     status = params[:status] ? params[:status] : 'process'
  #     if @exchange_request.update(approved_by_responder: params[:approved], status: status, responder_status: params[:responder_status], requester_status: params[:requester_status], time_of_change_responder_status: Date.today, time_of_change_requester_status: Date.today)
  #       format.html { redirect_to profile_exchange_requests_path,  notice: 'Exchange request was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @exchange_request }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @exchange_request.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    respond_to do |format|
      status = params[:status] ? params[:status] : 'process'
      if @exchange_request.update(approved_by_responder: params[:approved], status: status, responder_status: params[:responder_status], requester_status: params[:requester_status], time_of_change_responder_status: Date.today, time_of_change_requester_status: Date.today)
        format.html { redirect_to profile_exchange_requests_path,  notice: 'Exchange request was successfully updated.' }
        format.json { render :show, status: :ok, location: @exchange_request }
      else
        format.html { render :edit }
        format.json { render json: @exchange_request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @exchange_request.destroy
    respond_to do |format|
      format.html { redirect_to exchange_requests_path(current_user.profile.id), notice: 'Request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_exchange_request
    @exchange_request = ExchangeRequest.find(params[:id])
  end

end
