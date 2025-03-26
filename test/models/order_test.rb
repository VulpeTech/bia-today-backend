# == Schema Information
#
# Table name: orders
#
#  id                  :integer          not null, primary key
#  customer_user_id    :integer          not null
#  product_id          :integer
#  value               :decimal(10, 2)   not null
#  status              :string           not null
#  order_type          :string           not null
#  points              :decimal(10, 2)   not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  whatsapp_message_id :integer
#
# Indexes
#
#  index_orders_on_customer_user_id     (customer_user_id)
#  index_orders_on_product_id           (product_id)
#  index_orders_on_whatsapp_message_id  (whatsapp_message_id)
#

require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
