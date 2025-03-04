class Service < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :name, presence: true
  validates :daily_rate, presence: true, numericality: { greater_than: 0 }
end
