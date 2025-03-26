class Whatsapp::Messages::AcceptPointsOptinMessage < Whatsapp::WebhookHandlerImpl
  def call(message_id:)
    whatsapp_message = @customer.whatsapp_messages.find_by(message_id: message_id)

    puts "whatsapp_message: #{whatsapp_message}"
    puts "Message ID: #{message_id}"

    if whatsapp_message.blank?
      @whatsapp_service.send_with_actions(
        body: 'Não foi possível encontrar a mensagem, por favor, tente novamente.',
        buttons: [Whatsapp::Buttons.new(text: 'Voltar ao menu', id: 'voltar_ao_menu')],
        header: 'Bia Today',
        footer: 'Selecione uma opção para continuar'
      )
    end

    if @customer.has_accepted_terms
      @whatsapp_service.send_with_actions(
        body: 'Você já aceitou os termos e seus pontos já foram adicionados!',
        buttons: [Whatsapp::Buttons.new(text: 'Voltar ao menu', id: 'voltar_ao_menu')],
        header: 'Bia Today',
        footer: 'Selecione uma opção para continuar'
      )

      return
    end

    order = @customer.orders.find_by(whatsapp_message: whatsapp_message)

    if order.blank? || order.order_type != 'credit' || order.status != 'pending'
      @whatsapp_service.send_with_actions(
        body: 'Pedido não encontrado, por favor, tente novamente.',
        buttons: [Whatsapp::Buttons.new(text: 'Voltar ao menu', id: 'voltar_ao_menu')],
        header: 'Bia Today',
        footer: 'Selecione uma opção para continuar'
      )

      return
    end

    icons = {
      '0': "1️⃣",
      '1': "2️⃣",
      '2': "3️⃣",
      '3': "4️⃣"
    }

    products = order.user.products.map do |product|
      "#{icons[product.id]} #{product.name} - #{product.price} pontos"
    end

    @whatsapp_service.send_with_actions(
      body: "Agradecemos por ter aceitado os termos, seus pontos foram adicionados e estarão disponíveis para utilização em 24hrs

Confira algumas opções de produtos que você pode resgatar com seus pontos!

#{products.join("\n")}",
      buttons: [Whatsapp::Buttons.new(text: 'Voltar ao menu', id: 'voltar_ao_menu')],
      header: 'Bia Today',
      footer: 'Selecione uma opção para continuar'
    )

    @customer.update(has_accepted_terms: true)
    order.update(status: 'approved')
  end
end
