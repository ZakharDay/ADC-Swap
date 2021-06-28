class Organisation < ApplicationRecord
  has_many :programs
  has_many :courses
  has_many :minors
  has_many :archived_exchanges

  acts_as_tree order: 'name'
end
