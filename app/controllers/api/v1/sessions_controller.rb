class Api::V1::SessionsController < ApplicationController
  before_action :set_user
  before_action :authenticate_user

  def create
    render json: {'api_key': user.api_key}, status:200
  end

  private

  attr_reader :user

  def set_user
    @user = User.find_by(email: params['email'])
  end

  def authenticate_user
    render json: {'data': "Bad Username or Password"}, status: 404 unless valid_login?
  end

  def valid_login?
    user.nil? || !user.authenticate(params['password'])
  end
end