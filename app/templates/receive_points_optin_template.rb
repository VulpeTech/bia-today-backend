class ReceivePointsOptinTemplate
  def initialize(order:, customer:, user:)
    @order = order
    @customer = customer
    @user = user
  end

  def build
    [
      { type: "text", text: @user.name },
      { type: "text", text: @order.points.to_s },
      { type: "text", text: @order.value.to_s },
      { type: "text", text: Time.current.to_date.to_s },
      { type: "text", text: @user.name }
    ]
  end
end
