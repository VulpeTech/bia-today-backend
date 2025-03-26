class Whatsapp::WebhookHandlerImpl
  def initialize(whatsapp_service:, customer:)
    @whatsapp_service = whatsapp_service
    @customer = customer
  end
end
