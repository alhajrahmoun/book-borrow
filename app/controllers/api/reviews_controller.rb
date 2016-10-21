class Api::ReviewsController < ApplicationController
	before_action :authenticate_user!
	before_action :check_if_approved, only: [:create]
	def index
		reviews = Review.where(book_id: params[:book_id]).to_json
		reviews_hash = JSON.parse(reviews)
		reviews_hash.each do |review|
			review['user_name'] = User.find(review['user_id']).name
		end
		render json: {reviews: reviews_hash}
	end

	def create
		@category = Category.find(params[:category_id])
		@book = @category.books.find(params[:book_id])
		@review = @book.reviews.build(review_params)
		@review.user_id = current_user.id
		if @review.save
			render status: 200, json:{
					message: "review created successfully!",
					book: @book,
					review: @review
				}.to_json
		else
			head 403
		end
	end

	def destroy
		@category = Category.find(params[:category_id])
		@book = @category.books.find(params[:book_id])
		@review = @book.reviews.find(params[:id])
		if @review.destroy
			render status: 200, json:{
					message: "review deleted successfully!",
				}.to_json
		else
			head 403
		end
	end

	private
	def review_params
		params.require("review").permit(:content, :rating)
	end

	protected
	def check_if_approved
	    unless current_user.approved
	      render json: {error: [message: "انتظر تفعيل الحساب من الإدارة"]}
	    end
 	end
end