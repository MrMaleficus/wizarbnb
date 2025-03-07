class UsersController < ApplicationController
  def index
    @users = User.paginate(page: params[:page], per_page: 36)
  end

  def show
    if user_signed_in?
      if current_user.id == params[:id].to_i
        redirect_to dashboard_path
        end
    end
    @user = User.find(params[:id])
    @services = @user.services
    @bookings = @user.bookings
  end

end
