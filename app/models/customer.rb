# == Schema Information
#
# Table name: customers
#
#  id         :integer          not null, primary key
#  name       :string
#  cellphone  :string           not null
#  cpf_cnpj   :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Customer < ApplicationRecord
  has_many :customer_users
  has_many :users, through: :customer_users
  has_many :orders, through: :customer_users
end
