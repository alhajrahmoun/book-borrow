class AddCategoryRefToSubCategories < ActiveRecord::Migration[5.0]
  def change
    add_reference :sub_categories, :category, foreign_key: true
  end
end
