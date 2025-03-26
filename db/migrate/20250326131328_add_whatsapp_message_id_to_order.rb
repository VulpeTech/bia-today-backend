class AddWhatsappMessageIdToOrder < ActiveRecord::Migration[8.0]
  def change
    add_reference :orders, :whatsapp_message, null: true
  end
end
