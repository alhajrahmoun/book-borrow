class Book < ApplicationRecord
	belongs_to :category
	belongs_to :sub_category
	has_many :reviews, dependent: :destroy

	belongs_to :owner, class_name: "User"
	belongs_to :subscriber, class_name: "User"

	include PgSearch
	pg_search_scope :search_by_name, :against => :name
end
