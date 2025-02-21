# frozen_string_literal: true

class Api::Authentication::RegisterController < ApplicationController
  skip_before_action :authenticate_request

  def create
    exists = User.validate_existance(
      email: register_params[:email],
      cellphone: register_params[:cellphone]
    )

    raise(ActiveRecord::RecordInvalid, exists) if exists.present?

    @user = User.create!(register_params)

    @token = JwtService.encode(user_id: @user.id)

    render('api/authentication/register/create', status: :created)
  end

  private

  def register_params
    params.require(:user).permit(:username, :password, :full_name, :email, :birthdate, :cellphone)
  end
end
