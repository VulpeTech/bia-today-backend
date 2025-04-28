# == Schema Information
#
# Table name: whatsapp_messages
#
#  id            :string           not null, primary key
#  error_details :string
#  error_message :string
#  status        :string           not null
#  template      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  customer_id   :string           not null
#  message_id    :string           not null
#
# Indexes
#
#  index_whatsapp_messages_on_customer_id  (customer_id)
#

class WhatsappMessage < ApplicationRecord
  belongs_to :customer

  validates :message_id, presence: true
  validates :status, presence: true

  has_one :order
end
