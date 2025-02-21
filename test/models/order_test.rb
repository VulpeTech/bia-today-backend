# == Schema Information
#
# Table name: orders
#
#  id               :integer          not null, primary key
#  customer_user_id :integer          not null
#  product_id       :integer
#  value            :integer          not null
#  status           :string           not null
#  type             :string           not null
#  points           :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_orders_on_customer_user_id  (customer_user_id)
#  index_orders_on_product_id        (product_id)
#

require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
