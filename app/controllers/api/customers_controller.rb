class Api::CustomersController < ApplicationController
  def show
    @customer = @current_user.customers.find_by(cellphone: Cellphone.new(params[:cellphone]).to_s)

    return render json: { error: 'Customer not found' }, status: :not_found if @customer.nil?

    @points = @customer.calculate_points(user: @current_user)
  end
end
