class Api::SubscribtionsController < ApplicationController
	def index
		@category = Category.find(params[:category_id])
		@book = @category.books.find(params[:book_id])
		render json: {subscribtion: [Subscribtion.last]}
	end

	def create
		@category = Category.find(params[:category_id])
		@book = @category.books.find(params[:book_id])
		@subscribtion = Subscribtion.new(subscribtion_params)
		@subscribtion.book_id = @book.id
		@subscribtion.user_id = 1
		if @subscribtion.save
			render status: 200, json:{
					message: "sbscribtion created successfully!",
					subscribtion: [@subscribtion]
				}.to_json
		else
			head 401
		end
	end

	def destroy
		@subscribtion = Subscribtion.find(params[:id])
		@subscribtion.destroy
	end

	private 
	def subscribtion_params
		params.require("subscribtion").permit("borrow_date","approved","returned_back")
	end
end