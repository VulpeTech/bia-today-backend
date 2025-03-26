class Whatsapp::Order::RefuseOrder < ::Whatsapp::Order::OrderHandler
  def call(message_id:)
    verify_order(message_id: message_id)

    @order.update(status: 'refused')
    self.send_order_message(status: 'refused')
  end
end
