class CreatePenalties < ActiveRecord::Migration[5.0]
  def change
    create_table :penalties do |t|
      t.string :description
      t.integer :points
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
