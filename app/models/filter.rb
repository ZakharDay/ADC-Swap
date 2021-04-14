class Filter < ApplicationRecord
  belongs_to :profile, optional: true
  belongs_to :city, optional: true
end
