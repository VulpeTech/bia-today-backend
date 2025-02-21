class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.integer :price, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
