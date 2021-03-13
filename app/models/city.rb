class City < ApplicationRecord
  has_many :minors
  has_many :filters

  def as_json
    {
      id: id,
      name: name
    }
  end
end
