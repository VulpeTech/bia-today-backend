class Api::OrdersController < ApplicationController
  before_action :initialize_pagination_params, only: :index
  before_action :initialize_customer, only: :create

  def index
    @orders = @current_user.orders

    @total = @orders.count

    @orders = @orders.includes(:customer)
                      .ransack(search_params)
                      .result
                      .offset(@offset)
                      .limit(@limit)
  end

  def create
    points = order_params[:purchase_value] * @current_user.tax

    ActiveRecord::Base.transaction do
      @order = @customer.customer_users.find_or_create_by(user: @current_user)
                      .orders.create!(
                        status: @customer.has_accepted_terms ? 'approved' : 'pending',
                        points: points,
                        order_type: 'credit',
                        value: order_params[:purchase_value],
                      )

    template = @customer.has_accepted_terms ?
      ReceivePointsTemplate.new(order: @order, customer: @customer, user: @current_user)
    : ReceivePointsOptinTemplate.new(order: @order, customer: @customer, user: @current_user)

    whatsapp_message = whatsapp_service.send_with_template(
      template: @customer.has_accepted_terms ? 'modelo_receber_pontos' : 'modelo_receber_pontos_optin',
      variables: template.build
    )

    @order.update!(whatsapp_message: whatsapp_message)

      render 'api/orders/create', status: :created
    rescue => e
      render json: { message: e.message }, status: :unprocessable_entity
    end
  end

  private

  def initialize_customer
    @customer = Customer.find_or_create_by_cellphone(cellphone: order_params[:cellphone])
  end

  def whatsapp_service
    WhatsappService.new(
      phone_number: @customer.cellphone,
      customer: @customer
    )
  end

  def order_params
    params.require(:order).permit(:cellphone, :purchase_value)
  end

  def search_params
    params.fetch(:filters, {}).permit(
      :cellphone_cont,
      :points_gteq,
      :points_lteq,
      :created_at_gteq,
      :created_at_lteq,
      :value_gteq,
      :value_lteq,
      :customer_id_eq,
      :s,
      order_type_in: [],
      status_in: []
    )
  end
end
