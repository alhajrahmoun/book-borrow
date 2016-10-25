class CreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.integer :book_id
      t.string :name
      t.string :author
      t.string :translator
      t.integer :num_of_pages
      t.string :page_size
      t.string :publishing_house
      t.string :group
      t.boolean :approved
      t.boolean :returned_back
      t.date :borrow_date
      t.boolean :available, default: true

      t.timestamps
    end
  end
end
