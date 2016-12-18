class ReviewsController < ApplicationController
	def index
		@reviews = Review.order(created_at: :desc)
	end

	def destroy
		@review = Review.find(params[:id])
		@review.destroy
		redirect_to reviews_path
	end
end