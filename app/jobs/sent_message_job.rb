class SentMessageJob < ApplicationJob
  queue_as :default

  def perform(message)
    my = ApplicationController.render(
      partial: 'message/my',
      locals: {message: message}
    )
    theits = ApplicationController.render(
      partial: 'message/theirs',
      locals: {message: message}
    )

    ActionCable.server.broadcast "room_channel_#{message.exchange_request_id}", my: my, theits: theits, message:message
  end
end
