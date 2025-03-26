class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :customer_user, null: false, foreign_key: true
      t.references :product, foreign_key: true
      t.decimal :value, precision: 10, scale: 2, null: false
      t.string :status, null: false
      t.string :order_type, null: false
      t.decimal :points, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
