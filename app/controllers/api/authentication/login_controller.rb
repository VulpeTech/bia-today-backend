# frozen_string_literal: true

class Api::Authentication::LoginController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @user = User.find_by_login(
      email: login_params[:login],
      cellphone: login_params[:login]
    )

    unless @user&.authenticate(login_params[:password])
      return render json: { message: I18n.t('errors/messages.invalid_login') },
                    status: :unauthorized
    end

    @token = JwtService.encode(user_id: @user.id)
  rescue StandardError => e
    puts "Error: #{e.message}"
    render json: { message: I18n.t('errors/messages.invalid_login') }, status: :unauthorized
  end

  private

  def login_params
    params.require(:user).permit(:login, :password)
  end
end
