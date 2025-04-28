class CreateWhatsappMessage < ActiveRecord::Migration[8.0]
  def change
    create_table :whatsapp_messages, id: :string do |t|
      t.string :message_id, null: false
      t.string :status, null: false
      t.string :template
      t.references :customer, null: false, type: :string
      t.string :error_message
      t.string :error_details

      t.timestamps
    end
  end
end
