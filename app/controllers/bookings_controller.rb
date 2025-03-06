class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:accept, :decline]
  def index
  end

  def show
  end

  def new
    @service = Service.find(params[:service_id])
    @booking = Booking.new
    @booking.service = @service
    @booked_dates = @service.bookings.map do |booking|
      { from: booking.start_date, to: booking.end_date }
    end
  end

  def create
    @booking = Booking.new
    booking_params = params.require(:booking).permit(:start_date, :comment)
    if booking_params[:start_date].present?
      dates = booking_params[:start_date].split(" to ")
      start_date = Date.parse(dates[0])
      if dates[1].present?
        end_date = Date.parse(dates[1])
      else
        end_date = start_date
      end
      @booking = Booking.new(start_date: start_date, end_date: end_date)
      @booking.service = Service.find(params[:service_id])
      @booking.comment = booking_params[:comment]
      @booking.user = current_user
      @booking.pending!
      if @booking.save
        redirect_to dashboard_path
      else
        render :new, status: :unprocessable_entity
      end
    else
      @booking.errors.add(:start_date, "Date requise")
      render :new, status: :unprocessable_entity
    end
  end


  def accept
    if @booking.accept!
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "Réservation acceptée." }
      end
    else
      respond_to do |format|
        format.html { redirect_to dashboard_path, alert: "Erreur lors de l'acceptation." }
      end
    end
  end

  def decline
    if @booking.decline!
      respond_to do |format|
        format.html { redirect_to dashboard_path, notice: "Réservation refusée." }
      end
    else
      respond_to do |format|
        format.html { redirect_to dashboard_path, alert: "Erreur lors du refus." }
      end
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :comment)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end

end
