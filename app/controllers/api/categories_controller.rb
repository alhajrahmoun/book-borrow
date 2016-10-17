class Api::CategoriesController < ApplicationController
	before_action :authenticate_user!
	def index
		render json: {categories: Category.all}
	end

	def show
		if current_user.borrow_group == "A"
			render json: {books: Category.find(params[:id]).books.where(group: "A")}
		elsif current_user.borrow_group == "B"
			render json: {books: Category.find(params[:id]).books.where(group: ['A','B'])}
		elsif current_user.borrow_group == "C"
			render json: {books: Category.find(params[:id]).books}
		end	
	end
end