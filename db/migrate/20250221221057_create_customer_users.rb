class CreateCustomerUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :customer_users, id: :string do |t|
      t.references :customer, null: false, foreign_key: true, type: :string
      t.references :user, null: false, foreign_key: true, type: :string

      t.timestamps
    end
  end
end
