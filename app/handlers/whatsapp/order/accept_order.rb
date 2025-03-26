class Whatsapp::Order::AcceptOrder < ::Whatsapp::Order::OrderHandler
  def call(message_id:)
    verify_order(message_id: message_id)

    points = @customer.calculate_points(user: @order.user)

    if points < @order.points
      @whatsapp_service.send_with_actions(
        body: "Você não tem pontos suficientes para realizar essa compra",
        footer: "Selecione uma opção para continuar",
        buttons: [Whatsapp::Buttons.new(text: 'Voltar ao menu', id: 'voltar_ao_menu')],
        header: 'Bia Today'
      )

      return
    end

    @order.update!(status: 'approved')
    @customer.update!(has_accepted_terms: true) if @customer.has_accepted_terms == false
    self.send_order_message(status: 'approved')
  end
end
