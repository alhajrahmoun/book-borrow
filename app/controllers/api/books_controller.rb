class Api::BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :check_if_approved, only: [:subscribe]
	
	def show
		category = Category.find(params[:category_id])
		book = category.books.find(params[:id]).to_json
		book_hash = JSON.parse(book)
		book_hash["category"] = category.name
		render json: {book: [book_hash]}
	end

	def subscribe
		@book = Book.find(params[:id])
		if @book.available
			if current_user.borrow_group >= @book.group
				@book.subscriber_id = current_user.id
				@book.borrow_date = Date.today
				@book.approved = false
				@book.borrow_times = @book.borrow_times + 1
				@book.available = false
				if @book.save
					render status: 200, json:{
						message: ["book subscribed successfully"]
					}.to_json
				end
			end
		else
			render status: 401, json:{
				error: ["book is not available"] 
				}.to_json
		end
	end

	def unsubscribe
		@book = Book.find(params[:id])
		unless @book.available
			if current_user.borrow_group >= @book.group
				@book.subscriber_id = nil
				@book.borrow_times = @book.borrow_times - 1 if @book.borrow_date == Date.today
				@book.borrow_date = nil
				@book.approved = nil
				@book.available = true
				if @book.save
					render status: 200, json:{
						message: ["book unsubscribed successfully"]
					}.to_json
				end
			end
		end
	end

	def search
		response = []
		result = Book.search_by_name(params[:search])
		result.each do |r|
			result_hash = {name: r.name, url: "api/categories/#{r.category_id}/books/#{r.id}"}
			response.push(result_hash)
		end
		render json: {result: response}
	end

	def create
		@category = Category.find(params[:category_id])
		@book = @category.books.build(book_params)
		if @book.save
			render status: 200, json:{
					message: "book created successfully!",
					book: [@book]
				}.to_json
		else
			head 403
		end
	end

	def update
		@category = Category.find(params[:category_id])
		@book = @category.books.build(book_params)
		if @book.update(book_params)
			render status: 200, json:{
					message: "book updated successfully!",
					book: [@book]
				}.to_json
		else
			head 403
		end
	end

	def destroy
		@category = Category.find(params[:category_id])
		@book = @category.books.find(params[:id])
		if @book.destroy
			render status: 200, json:{
					message: "book deleted successfully!"
				}.to_json
		else
			render status: 401, json:{
					errors: [@book.errors]
				}.to_json
		end
	end

	def most_borrowed
		most_borrowed_books = Book.order(borrow_times: "DESC").limit(15).to_a
		render json: {books: most_borrowed_books}
	end

	def favorite_books
		category_id = Category.where(name: current_user.favorite_book_type).first
		favorite_books = Book.where(category_id: category_id).order(borrow_times: "DESC").limit(15).to_a	
		render json: {books: favorite_books}
	end

	private
	def book_params
		params.require("book").permit(:book_id,:name,:author,:translator,:num_of_pages,:page_size,:publishing_house,:group,:owner_id,:category_id,:sub_category_id,:available)
	end

	protected
	def check_if_approved
	    unless current_user.approved
	      render status: 403, json:{
					error: ["انتظر تفعيل الحساب من الإدارة"]
				}.to_json
	    end
 	end
end