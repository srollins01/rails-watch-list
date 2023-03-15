class ReviewsController < ApplicationController
  before_action :set_review, only: :destroy
  before_action :set_list, only: :create

  def create
    @review = Review.new(review_params)
    @review.list = @list
    if @review.save
      redirect_to list_path(@list)
    else
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to list_path(@review.list), status: :see_other
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
