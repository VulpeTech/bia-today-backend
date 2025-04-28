# == Schema Information
#
# Table name: users
#
#  id              :string           not null, primary key
#  cellphone       :string           not null
#  email           :string           not null
#  name            :string           not null
#  password_digest :string           not null
#  tax             :decimal(10, 2)   not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
