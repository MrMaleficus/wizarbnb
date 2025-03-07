class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :name, presence: true
  validates :daily_rate, presence: true, numericality: { greater_than: 0 }
  validates :rating, numericality: { greater_than: -1, less_than: 6 }

  include PgSearch::Model
  pg_search_scope :search_by_name,
    against: [ :name ],
    using: {
      tsearch: { prefix: true }
    }

  def star_rating
    plain_star = "<i class='fa-solid fa-star' style='color:gold'></i>"
    half_star = "<i class='fa-solid fa-star-half' style='color:gold'></i>"
    s_rating = self.rating.floor
    stars = plain_star * s_rating
    stars += half_star if self.rating - s_rating > 0.5
    stars
  end
end
