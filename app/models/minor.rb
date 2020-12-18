class Minor < ApplicationRecord
  has_many :courses
  has_many :profiles
  has_many :exchange_minors
  belongs_to :program
end
