class ReceivePointsTemplate
  def initialize(order:, customer:, user:)
    @order = order
    @customer = customer
    @user = user
  end

  def build
    first_fourth_products = @user.products
                                 .select(:name, :points)
                                 .first(4)
                                 .map { |product| "#{product.name} - #{product.points} pontos" }

    limit_date = @order.created_at + Order::POINTS_EXPIRATION_DAYS.days

    [
      { type: "text", text: @user.name },
      { type: "text", text: String(@order.points) },
      { type: "text", text: String(@order.value) },
      { type: "text", text: String(@customer.points) },
      { type: "text", text: first_fourth_products[0] ?? "-" },
      { type: "text", text: first_fourth_products[1] ?? "-" },
      { type: "text", text: first_fourth_products[2] ?? "-" },
      { type: "text", text: first_fourth_products[3] ?? "-" },
      { type: "text", text: limit_date.to_date.to_s(:long_ordinal) },
    ]
  end
end
