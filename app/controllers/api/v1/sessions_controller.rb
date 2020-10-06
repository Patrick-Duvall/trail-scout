class Api::V1::SessionsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user

  def create
    render json: user, serializer: Api::V1::UserSerializer
  end

  private

  attr_reader :user

  def set_user
    @user = User.find_by(email: params['email'])
  end

  def authenticate_user
    render json: {'error': "Bad Username or Password"}, status: 404 if invalid_login?
  end

  def invalid_login?
    user.nil? || !user.authenticate(params['password'])
  end
end