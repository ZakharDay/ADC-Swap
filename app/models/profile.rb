class Profile < ApplicationRecord
  has_many :exchange_minors
  has_many :exchange_requests, foreign_key: 'requester_id'
  has_many :exchange_responses, class_name: 'ExchangeRequest', foreign_key: 'responder_id'
  has_many :whished_minors
  belongs_to :minor

  has_many :filters
  #
  # has_many :exchange_requests, foreign_key: 'requester_id'
  # has_many :exchange_responses, class_name: 'ExchangeRequest', foreign_key: 'responder_id'

  belongs_to :user

  has_many :messages
end
