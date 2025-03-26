class Whatsapp::Order::OrderHandler < Whatsapp::WebhookHandlerImpl
  protected

  def verify_order(message_id:)
    whatsapp_message = @customer.whatsapp_messages.find_by(message_id: message_id)
    @order = whatsapp_message.order

    if @order.blank?
      @whatsapp_service.send_with_actions(
        body: 'Não foi possível encontrar o pedido, por favor, tente novamente.',
        buttons: [Whatsapp::Buttons.new(text: 'Voltar ao menu', id: 'voltar_ao_menu')],
        header: 'Bia Today'
      )

      raise ActiveRecord::RecordNotFound
    end

    if @order.status != 'pending'
      user = @order.user

      @whatsapp_service.send_with_actions(
        body: "Olá! Parece que este pedido já foi respondido, caso tenha alguma dúvida, entre em contato com o responsável pela emissão:

#{user.name}
#{user.cellphone}
#{user.email}",
        buttons: [Whatsapp::Buttons.new(text: 'Voltar ao menu', id: 'voltar_ao_menu')],
        header: 'Bia Today',
        footer: 'Selecione uma opção para continuar'
      )

      raise ActiveRecord::RecordNotFound
    end
  end

  def send_order_message(status:)
    message = status == 'approved' ? 'aprovado' : 'rejeitado'

    @whatsapp_service.send_with_actions(
      body: "Agradecemos por utilizar nossos serviços, seu pedido foi *#{message}* com sucesso!",
      buttons: [Whatsapp::Buttons.new(text: 'Consultar pontos', id: 'consultar_pontos')],
      header: 'Bia Today',
      footer: 'Selecione uma opção para continuar'
    )
  end
end
