class ReviewsController < ApplicationController
  after_action :update_service_rating, only: [:create]

  def update_service_rating
    return unless @service.reviews.any?
    @service.update(rating: @service.reviews.average(:rating))
  end

  def new
    @review = Review.new
    @service = Service.find(params[:service_id])
  end

  def create
    @review = Review.new(review_params)
    @service = Service.find(params[:service_id])
    @review.service = @service
    @review.user = current_user
    if @review.save
      redirect_to dashboard_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :content)
  end

end
