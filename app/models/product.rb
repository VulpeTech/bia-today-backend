# == Schema Information
#
# Table name: products
#
#  id          :string           not null, primary key
#  description :text
#  name        :string           not null
#  price       :decimal(10, 2)   not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :string           not null
#
# Indexes
#
#  index_products_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#

class Product < ApplicationRecord
  has_paper_trail

  belongs_to :user
  has_many :orders
  has_many :customer_users, through: :orders
  has_many :customers, through: :customer_users
end
