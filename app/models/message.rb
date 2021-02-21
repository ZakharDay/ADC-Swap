class Message < ApplicationRecord
  belongs_to :profile
  belongs_to :exchange_request
end
