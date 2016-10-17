class Category < ApplicationRecord
	has_many :books
	has_many :sub_categories

	def self.list_categories
		categories = []
		Category.all.each do |cat|
           categories.push(cat.name)
		end
		categories
	end
end
