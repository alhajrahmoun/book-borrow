class AddCurrentRoundToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :current_round, :integer, :default => 10
  end
end
