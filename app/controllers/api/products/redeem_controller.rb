class Api::Products::RedeemController < ApplicationController
  def create
    product = @current_user.products.find(product_params[:id])
    @customer = Customer.find(product_params[:customer_id])

    if product.price > @customer.calculate_points(user: @current_user)
      return render json: { message: 'Você não tem pontos suficientes para resgatar este produto' }, status: :unprocessable_entity
    end

    ActiveRecord::Base.transaction do
      @order = @customer.customer_users
                        .find_or_create_by(user: @current_user)
                        .orders.create!(
                          status: 'pending',
                          order_type: 'debit',
                          value: product.price,
                          points: product.price)

      template = RedeemProductTemplate.new(order: @order, customer: @customer, user: @current_user, product: product)

      whatsapp_message = whatsapp_service.send_with_template(
        template: 'modelo_order',
        variables: template.build)

      @order.update!(whatsapp_message: whatsapp_message)
    end

    render 'api/orders/create', status: :created
  rescue => e
    render json: { message: e.message }, status: :unprocessable_entity
  end

  private

  def product_params
    params.require(:product).permit(:id, :customer_id)
  end

  def whatsapp_service
    WhatsappService.new(
      phone_number: @customer.cellphone,
      customer: @customer
    )
  end
end
