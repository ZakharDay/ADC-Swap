class Guest < ApplicationRecord
  belongs_to :filter, optional: true
end
