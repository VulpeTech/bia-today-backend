class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers, id: :string do |t|
      t.string :name
      t.string :cellphone, null: false
      t.string :cpf_cnpj
      t.string :email

      t.timestamps
    end
  end
end
