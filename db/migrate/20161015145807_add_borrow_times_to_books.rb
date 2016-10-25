class AddBorrowTimesToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :borrow_times, :integer, :default => 0
  end
end
