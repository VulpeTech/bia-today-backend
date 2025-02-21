# == Schema Information
#
# Table name: customer_users
#
#  id          :integer          not null, primary key
#  customer_id :integer          not null
#  user_id     :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_customer_users_on_customer_id  (customer_id)
#  index_customer_users_on_user_id      (user_id)
#

class CustomerUser < ApplicationRecord
  belongs_to :customer
  belongs_to :user

  has_many :orders
end
