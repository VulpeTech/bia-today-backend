class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products, id: :string do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.references :user, null: false, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
