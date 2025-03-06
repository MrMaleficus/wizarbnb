class Booking < ApplicationRecord
  enum status: { pending: 0, accepted: 1, declined: 2, passed: 3 }
  belongs_to :service
  belongs_to :user
  validates :start_date, presence: true
  validates :end_date, presence: true

  def total_price
    valid_days = (start_date...end_date).to_a
    valid_days.size * self.service.daily_rate
  end
  def accept!
    update!(status: :accepted)
  end

  def pending!
    update!(status: :pending)
  end

  def decline!
    update!(status: :declined)
  end

  def passed!
    update!(status: :passed)
  end

  def total_days
    if (end_date - start_date) == 0
      1
    else
      (end_date - start_date)
    end
  end
end

