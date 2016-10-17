class AddOwnerNameToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :owner_name, :string
  end
end
