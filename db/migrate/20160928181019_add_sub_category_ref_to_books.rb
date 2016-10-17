class AddSubCategoryRefToBooks < ActiveRecord::Migration[5.0]
  def change
    add_reference :books, :sub_category, foreign_key: true
  end
end
