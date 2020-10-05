class Api::V1::UsersController < ApplicationController

  before_action :confirm_password, only: [:create]

  def create
    user = User.new(email: user_params['email'], password: user_params['password'])
    if user.save
      render json: user, serializer: Api::V1::UserSerializer, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  attr_reader :user

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def password_match
    user_params["password"] == user_params['password_confirmation']
  end

  def confirm_password
    render json: {"data": "Passwords do not match."}, status: 404 unless password_match
  end
end