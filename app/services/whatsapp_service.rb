class WhatsappService
  def initialize(phone_number:, customer:)
    @phone_number = phone_number
    @customer = customer

    @url = "https://graph.facebook.com/v20.0/#{ENV['WHATSAPP_BUSINESS_ID']}/messages"
  end

  def send_message(message:)
    response = HTTParty.post(@url, body: {
      messaging_product: 'whatsapp',
      to: @phone_number,
      type: 'text',
      text: { body: message }
    }.to_json,
    headers: {
      'Authorization' => "Bearer #{ENV['WHATSAPP_ACCESS_TOKEN']}",
      'Content-Type' => 'application/json'
    })

    @body = JSON.parse(response.body)

    save_message(type: 'text')
  end

  def send_with_template(template:, variables: nil)
    response = HTTParty.post(@url, body: {
      messaging_product: 'whatsapp',
      to: @phone_number,
      type: 'template',
      template: {
        name: template,
        language: { code: 'pt_BR' },
        components: [
          {
            type: 'body',
            parameters: variables
          }
        ]
      }
    }.to_json,
    headers: {
      'Authorization' => "Bearer #{ENV['WHATSAPP_ACCESS_TOKEN']}",
      'Content-Type' => 'application/json'
    })

    @body = JSON.parse(response.body)

    save_message(type: 'template', template: template)
  end

  def send_with_actions(
    body:,
    header: 'Bia Today',
    footer: nil,
    buttons: []
  )
    response = HTTParty.post(@url, body: {
      recipient_type: 'individual',
      to: @phone_number,
      messaging_product: 'whatsapp',
      type: 'interactive',
      interactive: {
        type: 'button',
        header: { type: 'text', text: header || '' },
        body: { text: body || '' },
        footer: { text: footer || '' },
        action: { buttons: buttons.map(&:build) }
      }
    }.to_json,
    headers: {
      'Authorization' => "Bearer #{ENV['WHATSAPP_ACCESS_TOKEN']}",
      'Content-Type' => 'application/json'
    })

    @body = JSON.parse(response.body)

    save_message(type: 'action')
  end

  private

  def save_message(type:, template: nil)
    if @body['error'].present?
      WhatsappMessage.create!(
        customer_id: @customer.id,
        message_id: @body['error']['fbtrace_id'],
        status: 'rejected',
        template: template,
        error_message: @body['error']['message'],
        error_details: @body['error']['details']
      )

      return
    end

    WhatsappMessage.create!(
      customer_id: @customer.id,
      message_id: @body['messages'][0]['id'],
      status: 'sent',
      template: template
    )
  end
end
