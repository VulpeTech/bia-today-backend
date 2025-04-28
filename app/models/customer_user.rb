# == Schema Information
#
# Table name: customer_users
#
#  id          :string           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  customer_id :string           not null
#  user_id     :string           not null
#
# Indexes
#
#  index_customer_users_on_customer_id  (customer_id)
#  index_customer_users_on_user_id      (user_id)
#
# Foreign Keys
#
#  customer_id  (customer_id => customers.id)
#  user_id      (user_id => users.id)
#

class CustomerUser < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  has_many :orders
end
