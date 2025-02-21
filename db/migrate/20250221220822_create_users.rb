class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :cellphone, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :tax, null: false

      t.timestamps
    end
  end
end
