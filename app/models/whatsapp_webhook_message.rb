class WhatsappWebhookMessage
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :phone_number, :string
  attribute :message, :string

  validates :phone_number, presence: true
  validates :message, presence: true
  validates :status, presence: true
end
