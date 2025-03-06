class UsersController < ApplicationController
  def index
    if params[:query]
      @users = User.paginate(page: params[:page], per_page: 36).search_by_name(params[:query])
    else
      @users = User.paginate(page: params[:page], per_page: 36)
    end
  end

  def show
    @user = User.find(params[:id])
    @services = @user.services
    @bookings = @user.bookings
  end

end
