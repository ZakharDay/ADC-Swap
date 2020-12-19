class ExchangeMinor < ApplicationRecord
  belongs_to :profile
  belongs_to :minor

  def card
    {
      name: minor.name
    }
  end
end
