class Webhook::WhatsappController < Webhook::ApplicationController
  def create
    ActiveRecord::Base.transaction do
      message_params

      @whatsapp_webhook_handler = ::Whatsapp::WebhookHandler.new(
        whatsapp_service: @whatsapp_service,
        customer: @customer,
        text: @text,
        message_id: @message_id
      )

      @whatsapp_webhook_handler.call
    end

    head :ok
  rescue => e
    render json: { error: e.message }, status: :ok
  end

  private

  def message_params
    changes = params.dig(:entry, 0, :changes, 0, :value)

    @message_id = changes.dig(:messages, 0, :context, :id)
    @message = changes.dig(:messages, 0)

    @phone = @message.dig(:from)
    @name = changes.dig(:contacts, 0, :profile, :name)

    @text =  @message&.dig(:text, :body) ||
             @message&.dig(:interactive, :button_reply, :title) ||
             @message&.dig(:interactive, :list_reply, :title) ||
             @message&.dig(:button, :text) ||
             @message&.dig(:button, :payload)

    if [@text, @phone, @name].include?(nil)
      raise ActiveRecord::RecordNotFound
    end

    @customer = Customer.find_or_create_by_cellphone(cellphone: @phone) do |customer|
      customer.name = @name
    end

    @whatsapp_service = WhatsappService.new(
      phone_number: @phone,
      customer: @customer
    )
  end
end
