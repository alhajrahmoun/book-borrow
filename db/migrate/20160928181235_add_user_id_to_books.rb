class AddUserIdToBooks < ActiveRecord::Migration[5.0]
  def change
    add_reference :books, :subscriber, foreign_key: true, foreign_key: { to_table: :users }
    add_reference :books, :owner, foreign_key: true, foreign_key: { to_table: :users }
  end
end
