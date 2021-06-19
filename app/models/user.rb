class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile

  after_create :create_profile

  # if email.include? "@edu.hse.ru"
  #   courses.push(sublink)
  # end

  def create_profile
    puts self.id
    p = Profile.create!(user_id: self.id, minor_id: 1, program_id: 7)
    ExchangeMinor.create!(profile_id: p.id, minor_id: p.minor.id)
  end
end
