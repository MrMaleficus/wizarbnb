class Review < ApplicationRecord
  belongs_to :service
  belongs_to :user
  validates :content, length: { maximum: 512 }
  validates :rating, presence: true, numericality: { greater_than: 0, less_than: 6 }
  validates :service_id, presence: true
  validates :user_id, presence: true


  def star_rating
    plain_star = "<i class='fa-solid fa-star' style='color:orange'></i>"
    half_star = "<i class='fa-solid fa-star-half' style='color:orange'></i>"
    rating = self.rating.floor
    stars = plain_star * rating
    stars += half_star if self.rating - rating > 0.5
    stars
  end

end
