# == Schema Information
#
# Table name: customers
#
#  id                 :string           not null, primary key
#  cellphone          :string           not null
#  cpf_cnpj           :string
#  email              :string
#  has_accepted_terms :boolean          default(FALSE)
#  name               :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Customer < ApplicationRecord
  has_paper_trail

  has_many :customer_users
  has_many :whatsapp_messages
  has_many :users, through: :customer_users
  has_many :orders, through: :customer_users

  def aggregate_points
    self.customer_users
        .joins(:orders, :user)
        .where(orders: { status: 'approved' })
        .select('users.name as company_name')
        .select('
          SUM(CASE WHEN orders.order_type = \'credit\' THEN orders.points ELSE 0 END) -
          SUM(CASE WHEN orders.order_type = \'debit\' THEN orders.points ELSE 0 END) as balance
        ')
        .group('users.name')
  end

  def calculate_points(user:)
    self.customer_users
        .joins(:orders, :user)
        .where(orders: { status: 'approved' })
        .where(user: user)
        .select('
          SUM(CASE WHEN orders.order_type = \'credit\' THEN orders.points ELSE 0 END) -
          SUM(CASE WHEN orders.order_type = \'debit\' THEN orders.points ELSE 0 END) as points
        ')
        .group('users.name')
        .first
        &.points || 0
  end

  def self.find_or_create_by_cellphone(cellphone:)
    phone = Cellphone.new(cellphone).to_s

    customer = Customer.find_by(cellphone: phone)

    return customer if customer.present?

    Customer.create!(cellphone: phone)
  end
end
