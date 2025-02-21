class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :customer_user, null: false, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :value, null: false
      t.string :status, null: false
      t.string :type, null: false
      t.integer :points, null: false

      t.timestamps
    end
  end
end
