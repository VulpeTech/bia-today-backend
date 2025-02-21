# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  cellphone       :string           not null
#  email           :string           not null
#  password_digest :string           not null
#  tax             :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


class User < ApplicationRecord
  has_secure_password

  has_many :products
  has_many :customer_users
  has_many :customers, through: :customer_users
  has_many :orders

  validates :name, presence: true
  validates :cellphone, presence: true
  validates :email, presence: true
  validates :tax, presence: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  validates :email, uniqueness: true
  validates :cellphone, uniqueness: true
  validates :tax, numericality: { greater_than: 0 }
  validates :tax, numericality: { less_than: 100 }
  validates :password, length: { minimum: 6 }
end
