class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users, id: :string do |t|
      t.string :name, null: false
      t.string :cellphone, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.decimal :tax, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
