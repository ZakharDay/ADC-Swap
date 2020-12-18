class Organisation < ApplicationRecord
  has_many :programs
  has_many :courses
end
