class Whatsapp::Messages::ConsultPointsMessage < Whatsapp::WebhookHandlerImpl
  def initialize(whatsapp_service:, customer:)
    @whatsapp_service = whatsapp_service
    @customer = customer
  end

  def call
    aggregate_points = @customer.aggregate_points

    @whatsapp_service.send_with_actions(
      body: "Claro! Segue seus pontos:

#{aggregate_points.map { |point| "*#{point.company_name}*: #{point.balance} pontos" }.join("\n")}",
      buttons: [Whatsapp::Buttons.new(text: 'Voltar ao menu', id: 'voltar_ao_menu')],
      header: 'Bia Today',
      footer: 'Selecione uma opção para continuar'
    )
  end
end
