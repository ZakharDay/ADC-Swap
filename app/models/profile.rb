class Profile < ApplicationRecord
  has_many :exchange_minors
  belongs_to :minor
  belongs_to :user
end
