# db/migrate_data.rb

class OldDatabaseRecord < ApplicationRecord
  self.abstract_class = true
  establish_connection :old_database
end

TABLES_MAPPER = {
  Customer: {
    old_table_name: "customers",
    columns: {
      id: "id",
      name: "name",
      cellphone: "phone",
      cpf_cnpj: "document",
      email: "email",
      created_at: "createdAt",
      updated_at: "updatedAt",
      has_accepted_terms: "hasAcceptedTerms",
    },
  },
  User: {
    old_table_name: "companies",
    columns: {
      id: "id",
      name: "name",
      tax: "fee",
      cellphone: "phone",
      password_digest: "password",
      created_at: "createdAt",
      updated_at: "updatedAt",
      email: "email",
    },
  },
  CustomerUser: {
    old_table_name: "customer_companies",
    columns: {
      id: "id",
      customer_id: "customerId",
      user_id: "companyId",
      created_at: "createdAt",
      updated_at: "updatedAt",
    },
  },
  Product: {
    old_table_name: "products",
    columns: {
      id: "id",
      name: "name",
      description: "description",
      price: "price",
      created_at: "createdAt",
      updated_at: "updatedAt",
      user_id: "companyId",
    },
  },
  WhatsappMessage: {
    old_table_name: "whatsapp_messages",
    columns: {
      id: "id",
      message_id: "messageId",
      status: "messageStatus",
      template: "template",
      customer_id: "customerId",
      error_message: "errorMessage",
      error_details: "errorDetails",
      created_at: "createdAt",
      updated_at: "updatedAt",
    },
  },
  Order: {
    old_table_name: "orders",
    columns: {
      id: "id",
      customer_user_id: "customerCompanyId",
      product_id: "productId",
      value: "value",
      status: "status",
      order_type: "type",
      points: "points",
      created_at: "createdAt",
      updated_at: "updatedAt",
      whatsapp_message_id: "whatsappMessageId",
    },
  },
}

def migrate_data
  TABLES_MAPPER.each do |model_name, config|
    model_class = model_name.to_s.constantize
    old_table = config[:old_table_name]
    columns_map = config[:columns]

    puts "Migrando #{model_name}..."

    old_rows = OldDatabaseRecord.connection.exec_query("SELECT * FROM #{old_table}")

    new_rows = old_rows.map do |old_row|
      attrs = {}

      columns_map.each do |new_column, old_column|
        attrs[new_column] = old_row[old_column.to_s]
      end

      attrs
    end

    # Insere tudo de uma vez, rápido, sem callbacks e sem validações
    model_class.insert_all(new_rows) if new_rows.any?

    puts "Migrado #{new_rows.size} registros para #{model_name}."
  end
end

# Executa
migrate_data;nil
