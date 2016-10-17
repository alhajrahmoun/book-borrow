class AddAverageToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :average, :float
  end
end
