class Profile < ApplicationRecord
  has_many :exchange_minors
  has_many :exchange_requests, foreign_key: 'requester_id'
  has_many :exchange_responses, class_name: 'ExchangeRequest', foreign_key: 'responder_id'
  has_many :whished_minors
  belongs_to :minor
  belongs_to :user
end
