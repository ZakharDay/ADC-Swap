class City < ApplicationRecord
  has_many :minors
  has_many :filters
end
