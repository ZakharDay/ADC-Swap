class ExchangeRequest < ApplicationRecord
  belongs_to :requester, class_name: 'Profile', foreign_key: 'requester_id'
  belongs_to :responder, class_name: 'Profile', foreign_key: 'responder_id'

  has_many :messages

end
