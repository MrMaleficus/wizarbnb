class Booking < ApplicationRecord
  belongs_to :service
  belongs_to :user
  validates :start_date, presence: true
  validates :end_date, presence: true

  def total_price
    valid_days = (start_date...end_date).to_a
    valid_days.size * self.service.daily_rate
  end

  def total_days
    if (end_date - start_date) == 0
      1
    else
      (end_date - start_date)
    end
  end
end

