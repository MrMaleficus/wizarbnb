class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :services, dependent: :destroy
  has_many :bookings, dependent: :destroy



  def average_rating
    self.services.map(&:rating).sum / self.services.size
  end

  def star_rating
    plain_star = "<i class='fa-solid fa-star' style='color:gold'></i>"
    half_star = "<i class='fa-solid fa-star-half' style='color:gold'></i>"
    rating = self.average_rating.floor
    stars = plain_star * rating
    stars += half_star if self.average_rating - rating > 0.5
    stars
  end



end
