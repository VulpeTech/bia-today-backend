# == Schema Information
#
# Table name: user_customers
#
#  id          :integer          not null, primary key
#  customer_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_user_customers_on_customer_id  (customer_id)
#  index_user_customers_on_user_id      (user_id)
#

require "test_helper"

class UserCustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
