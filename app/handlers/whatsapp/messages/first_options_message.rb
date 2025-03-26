class Whatsapp::Messages::FirstOptionsMessage < Whatsapp::WebhookHandlerImpl
  def initialize(whatsapp_service:, customer:)
    @whatsapp_service = whatsapp_service
    @customer = customer
  end

  def call
    greetings = @customer.name.present? ? "Olá, #{@customer.name.split(' ').first}!" : 'Olá!'

    @whatsapp_service.send_with_actions(
      body: "#{greetings}

Bem-vindo ao Bia Today!",
      buttons: [Whatsapp::Buttons.new(text: 'Consultar pontos', id: 'consultar_pontos')],
      header: 'Bia Today',
      footer: 'Selecione uma opção para continuar'
    )
  end
end
