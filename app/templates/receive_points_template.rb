class ReceivePointsTemplate
  def initialize(order:, customer:, user:)
    @order = order
    @customer = customer
    @user = user
  end

  def build
    first_fourth_products = @user.products
                                 .select(:name, :price)
                                 .first(4)
                                 .map { |product| "#{product.name} - #{product.price} pontos" }

    limit_date = @order.created_at + Order::POINTS_EXPIRATION_DAYS.days

    [
      { type: "text", text: @user.name },
      { type: "text", text: @order.points.to_s },
      { type: "text", text: @order.value.to_s },
      { type: "text", text: @customer.calculate_points(user: @user).to_s },
      { type: "text", text: first_fourth_products[0] || "-" },
      { type: "text", text: first_fourth_products[1] || "-" },
      { type: "text", text: first_fourth_products[2] || "-" },
      { type: "text", text: first_fourth_products[3] || "-" },
      { type: "text", text: limit_date.to_date.to_s }
    ]
  end
end
