class Review < ApplicationRecord
  belongs_to :service
  belongs_to :user
  validates :content, length: { maximum: 512 }
  validates :rating, presence: true, numericality: { greater_than: 0, less_than: 6 }
  validates :service_id, presence: true
  validates :user_id, presence: true
end
