class AddHasAcceptedTermsToCustomer < ActiveRecord::Migration[8.0]
  def change
    add_column :customers, :has_accepted_terms, :boolean, default: false
  end
end
