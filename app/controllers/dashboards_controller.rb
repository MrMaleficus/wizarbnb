class DashboardsController < ApplicationController
  STATUS_MESSAGE = {
    "pending" => "En attente",
    "accepted" => "Acceptée",
  }

  def show
    @services = current_user.services
    @user_services = Booking.all.select { |booking| booking.service.user == current_user }
    @user_bookings = current_user.bookings
    @messages = STATUS_MESSAGE
  end
end
