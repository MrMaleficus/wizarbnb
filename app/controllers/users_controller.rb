class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @services = @user.services
    @bookings = @user.bookings
  end

  #  def average_rating
  #    @user = User.find(params[:id])
  #    @services = @user.services
  #    @average_rating = @services.map(&:average_rating).sum / @services.size
  #  end

end
