class Whatsapp::WebhookFactory
  def initialize(whatsapp_service:, customer:, text:, message_id:)
    @whatsapp_service = whatsapp_service
    @customer = customer
    @text = text
    @message_id = message_id
  end

  def call
    text = @text.downcase

    case text
    when 'receber pontos (aceitar)'
      build_class(type: 'messages', description: 'AcceptPointsOptinMessage').call(message_id: @message_id)
    when 'aceitar'
      build_class(type: 'order', description: 'AcceptOrder').call(message_id: @message_id)
    when 'recusar'
      build_class(type: 'order', description: 'RefuseOrder').call(message_id: @message_id)
    when 'consultar pontos'
      build_class(type: 'messages', description: 'ConsultPointsMessage').call
    else
      build_class(type: 'messages', description: 'FirstOptionsMessage').call
    end
  end

  private

  def build_class(type:, description:)
    "::Whatsapp::#{type.capitalize}::#{description}".constantize.new(
      whatsapp_service: @whatsapp_service,
      customer: @customer
    )
  end
end
