class ExchangeMinor < ApplicationRecord
  belongs_to :profile
  belongs_to :minor
  has_many :whished_minors


  def card_index
    {
      city: minor.city.name,
      year: minor.start_year,
      address: minor.address,
      credits: minor.credits,
      minor: minor.name,
      whishedMinors: profile.whished_minors.collect { |wm| wm.minor.name.truncate(18) }

      # url: url нужно дополнить в контроллере
    }
  end

  def card_show
    {
      address: minor.address,
      credits: minor.credits,
      id: minor.id,
      student_id: profile_id,
      minor: minor.name,
      responsible: minor.responsible,
      description: minor.description,
      url: minor.url
    }
  end
end
