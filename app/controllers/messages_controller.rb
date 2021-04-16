class MessagesController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @message = Message.new
  end

  def create
    @message = Message.create!(msg_params)

    SentMessageJob.perform_later(@message)
  end

  private

  def msg_params
    params.require(:message).permit(:content, :profile_id, :exchange_request_id)
  end
end
