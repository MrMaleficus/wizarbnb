class DashboardsController < ApplicationController
  before_action :authenticate_user!, only: [:show]


  STATUS_MESSAGE = {
    "pending" => "En attente",
    "accepted" => "Acceptée",
    "passed" => "Passée",
  }

  def show
    @services = current_user.services
    @user_services = Booking.all.select { |booking| booking.service.user == current_user }
    @user_bookings = current_user.bookings
    @messages = STATUS_MESSAGE
  end
end
