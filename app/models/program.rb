class Program < ApplicationRecord
  has_many :minors
  belongs_to :organisation
end
