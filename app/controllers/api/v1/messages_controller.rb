class Api::V1::MessagesController < ApplicationController
  def create
    mes = Message.create!(exchange_request_id:params[:message][:exchange_request_id], profile_id:params[:message][:profile_id], content:params[:message][:content])

    SentMessageJob.perform_later(mes)
  end

  def index

  end
end
