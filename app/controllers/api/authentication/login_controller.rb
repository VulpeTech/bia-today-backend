# frozen_string_literal: true

class Api::Authentication::LoginController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @user = User.find_by(username: login_params[:username])

    unless @user&.authenticate(login_params[:password])
      return render json: { error: I18n.t('errors/messages.invalid_login') },
                    status: :unauthorized
    end

    @token = JwtService.encode(user_id: @user.id)
  rescue StandardError
    render json: { error: I18n.t('errors/messages.invalid_login') }, status: :unauthorized
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end
end
