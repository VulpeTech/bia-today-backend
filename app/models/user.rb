# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  cellphone       :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  tax             :decimal(10, 2)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ApplicationRecord
  has_paper_trail
  has_secure_password

  has_many :products
  has_many :customer_users
  has_many :customers, through: :customer_users
  has_many :orders, through: :customer_users

  validates :name, presence: true
  validates :cellphone, presence: true
  validates :email, presence: true
  validates :tax, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates :cellphone, uniqueness: true
  validates :tax, numericality: { greater_than: 0 }
  validates :tax, numericality: { less_than: 101 }
  validates :password, length: { minimum: 6 }

  after_create :create_first_products

  def self.verify_existance(params)
    existing_user = User.find_by_login(params)

    return if existing_user.blank?

    params[:cellphone] = User.format_cellphone(params[:cellphone])

    %i[email cellphone].each do |field|
      if existing_user.send(field) == params[field]
        existing_user.errors.add(field, I18n.t("modules/users/errors/messages.#{field}_taken"))
      end
    end

    existing_user
  end

  def self.find_by_login(params)
    puts "params: #{params}"
    params[:cellphone] = User.format_cellphone(params[:cellphone]) if params[:cellphone].present?

    User.where('email = ? OR cellphone = ?', params[:email], params[:cellphone]).first
  end

  def self.format_cellphone(cellphone)
    return if cellphone.blank?

    cellphone = cellphone.gsub(/\D/, '')

    return "#{cellphone[0..1]}9#{cellphone[1..]}" if cellphone.length == 10

    cellphone
  end

  private

  def verify_cellphone
    self.cellphone = User.format_cellphone(self.cellphone)
    errors.add(:cellphone, I18n.t('modules/users/errors/messages.cellphone_invalid')) if self.cellphone.length < 10
  end

  def create_first_products
    self.products.create!(name: 'Voucher R$ 5,00', price: 50.0, description: 'Voucher de compras na loja')
    self.products.create!(name: 'Voucher R$ 10,00', price: 100.0, description: 'Voucher de compras na loja')
    self.products.create!(name: 'Voucher R$ 20,00', price: 200.0, description: 'Voucher de compras na loja')
    self.products.create!(name: 'Voucher R$ 50,00', price: 500.0, description: 'Voucher de compras na loja')
  end
end
