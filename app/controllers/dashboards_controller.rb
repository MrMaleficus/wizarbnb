class DashboardsController < ApplicationController
  def show
    @services = current_user.services
    @user_services = Booking.all.select { |booking| booking.service.user == current_user }
    @user_bookings = current_user.bookings
  end
end
