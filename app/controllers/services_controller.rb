class ServicesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @services = Service.all
    #    @users = @services.map(&:user).uniq
    @users = User.all

  end

  def show
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @service.user = current_user
    if @service.save
      redirect_to dashboard_path
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def destroy
    @service = Service.find(params[:id])
    return if @service.user != current_user
    bookings = @service.bookings
    status = bookings.map(&:status).uniq
    if !status.include?("confirmed") && !status.include?("pending")
      @service.destroy
      redirect_to dashboard_path
    end
  end

  def total_price
    valid_days = (start_date...end_date).count { |day| day.wday != 0 && day.wday != 6 }
    valid_days * self.daily_rate
  end

  private

  def service_params
    params.require(:service).permit(:name, :daily_rate)
  end

end
