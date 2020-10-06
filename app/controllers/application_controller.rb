class ApplicationController < ActionController::API

  def validate_api_key
    return render json: {errors: ['Please provide an api_key']}, status: :unprocessable_entity unless
      params[:api_key]
    return render json: {errors: ['Invalid api_key']}, status: :unprocessable_entity unless
      User.find_by(api_key: params[:api_key])
  end

end
