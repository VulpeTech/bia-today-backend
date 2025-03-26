class Whatsapp::WebhookHandler
  def initialize(whatsapp_service:, customer:, text:, message_id:)
    @whatsapp_service = whatsapp_service
    @customer = customer
    @text = text
    @message_id = message_id
  end

  def call
    @whatsapp_webhook_factory = ::Whatsapp::WebhookFactory.new(
      whatsapp_service: @whatsapp_service,
      customer: @customer,
      text: @text,
      message_id: @message_id
    )

    @whatsapp_webhook_factory.call
  end
end
