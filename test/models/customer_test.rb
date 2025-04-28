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

require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
