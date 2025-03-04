class UsersController < ApplicationController
  def index
  end

  def show
    @user = User.find(params[:id])
    @services = @user.services
    @bookings = @user.bookings
  end
end
