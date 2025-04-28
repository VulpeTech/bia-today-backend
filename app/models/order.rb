# == Schema Information
#
# Table name: orders
#
#  id                  :string           not null, primary key
#  order_type          :string           not null
#  points              :decimal(10, 2)   not null
#  status              :string           not null
#  value               :decimal(10, 2)   not null
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  customer_user_id    :string           not null
#  product_id          :string
#  whatsapp_message_id :integer
#
# Indexes
#
#  index_orders_on_customer_user_id     (customer_user_id)
#  index_orders_on_product_id           (product_id)
#  index_orders_on_whatsapp_message_id  (whatsapp_message_id)
#
# Foreign Keys
#
#  customer_user_id  (customer_user_id => customer_users.id)
#  product_id        (product_id => products.id)
#

class Order < ApplicationRecord
  has_paper_trail

  belongs_to :customer_user

  belongs_to :product, optional: true
  belongs_to :customer_user, optional: true
  belongs_to :whatsapp_message, optional: true

  has_one :customer, through: :customer_user
  has_one :user, through: :customer_user

  POINTS_EXPIRATION_DAYS = 10 * 30

  def self.ransackable_attributes(_auth_object = nil)
    %w[status order_type customer_id created_at]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[customer customer_user product]
  end
end
