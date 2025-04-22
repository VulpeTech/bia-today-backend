class Api::ProductsController < ApplicationController
  before_action :set_product, only: %i[show update destroy]

  def index
    @products = @current_user.products
  end

  def create
    @product = @current_user.products.create!(product_params)
  end

  def show; end

  def update
    @product.update!(product_params)
  end

  def destroy
    @product.destroy!
  rescue SQLite3::ConstraintException => e
    render json: { message: 'Não foi possível excluir o produto, pois ele já foi associado a um pedido.' },
           status: :unprocessable_entity
  rescue => e
    render json: { message: "Não foi possível excluir o produto, pois ele já foi associado a um pedido." }, status: :unprocessable_entity
  end

  private

  def set_product
    @product = @current_user.products.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
