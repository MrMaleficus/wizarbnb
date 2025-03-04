class DashboardsController < ApplicationController
  def show
    @services = current_user.services
    @bookings = current_user.bookings
  end
end
