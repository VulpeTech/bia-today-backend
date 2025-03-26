class Api::UsersController < ApplicationController
  skip_before_action :authenticate_request

  def index
    @user = User.verify_existance(
      email: user_params[:email],
      cellphone: user_params[:cellphone]
    )
  end

  private

  def user_params
    params.require(:user).permit(:email, :cellphone)
  end
end
