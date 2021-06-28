class Minor < ApplicationRecord
  has_many :courses
  has_many :profiles
  has_many :exchange_minors
  has_many :whished_minors
  has_many :archived_exchanges

  belongs_to :program, optional: true
  belongs_to :organisation

  belongs_to :city

end
