# == Schema Information
#
# Table name: whatsapp_messages
#
#  id            :integer          not null, primary key
#  message_id    :string           not null
#  status        :string           not null
#  template      :string
#  customer_id   :integer          not null
#  error_message :string
#  error_details :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
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
