class ExchangeMinor < ApplicationRecord
  belongs_to :profile
  belongs_to :minor

  def card_index
    {
      # address: minor.address,
      # credits: minor.credits,
      minor: minor.name,
      whishedMinors: profile.whished_minors.collect { |wm| wm.minor.name }
      # url: url нужно дополнить в контроллере
    }
  end

  def card_show
    {
      # address: minor.address,
      # credits: minor.credits,
      minor: minor.name,
      responsible: minor.responsible,
      description: minor.description,
      url: minor.url
    }
  end
end
