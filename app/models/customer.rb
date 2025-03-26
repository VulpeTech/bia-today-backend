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
  has_paper_trail

  has_many :customer_users
  has_many :whatsapp_messages
  has_many :users, through: :customer_users
  has_many :orders, through: :customer_users

  def aggregate_points
    self.customer_users
        .joins(:orders, :user)
        .select('users.name as company_name')
        .select('
          SUM(CASE WHEN orders.order_type = \'credit\' AND orders.status = \'approved\' THEN orders.value ELSE 0 END) -
          SUM(CASE WHEN orders.order_type = \'debit\' AND orders.status = \'approved\' THEN orders.value ELSE 0 END) as balance
        ')
        .group('users.name')
  end

  def calculate_points(user:)
    self.orders
        .joins(customer_user: :user)
        .where(
          customer_user: { user: user },
          status: 'approved'
        )
        .select(
          'SUM(CASE WHEN orders.order_type = \'credit\' THEN orders.value ELSE 0 END) -
           SUM(CASE WHEN orders.order_type = \'debit\' THEN orders.value ELSE 0 END) as points'
        )
        .group('customer_users.customer_id')
        .first
        .points
  end

  def self.find_or_create_by_cellphone(cellphone:)
    formatted_cellphone = cellphone.gsub(/\D/, '')

    unless formatted_cellphone.start_with?('55')
      formatted_cellphone = formatted_cellphone.insert(0, '55')
    end

    if formatted_cellphone.length == 12
      formatted_cellphone = formatted_cellphone.insert(4, '9')
    end

    if formatted_cellphone.length != 13
      raise ActiveRecord::RecordInvalid, 'Cellphone must be 13 digits'
    end

    customer = Customer.find_by(cellphone: formatted_cellphone)

    return customer if customer.present?

    Customer.create!(cellphone: formatted_cellphone)
  end
end
