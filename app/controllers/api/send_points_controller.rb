class Api::SendPointsController < ApplicationController
  def create
    initialize_customer

    @order = @customer.orders.create!(
      status: 'pending',
      points: send_points_params[:points]
      user: @current_user,
      type: 'credit'
    )

    render('api/send_points/create', status: :created)
  end

  private

  def initialize_customer
    @customer = Customer.find_by(cellphone: send_points_params[:cellphone])

    @customer ||= Customer.create!(cellphone: send_points_params[:cellphone])
  end

  def send_points_params
    params.require(:send_points).permit(:cellphone, :points)
  end
end
