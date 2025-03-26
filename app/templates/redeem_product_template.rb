class RedeemProductTemplate
  def initialize(order:, customer:, user:, product:)
    @order = order
    @customer = customer
    @user = user
    @product = product
  end

  def build
    [
      { type: "text", text: @customer.cellphone },
      { type: "text", text: @user.name },
      { type: "text", text: @product.name },
      { type: "text", text: @product.price.to_s },
      { type: "text", text: (@customer.calculate_points(user: @user) - @product.price).to_s }
    ]
  end
end
