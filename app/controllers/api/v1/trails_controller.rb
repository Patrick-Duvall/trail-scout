class Api::V1::TrailsController < ApplicationController
  before_action :validate_api_key, only: [:index]
  before_action :validate_address, only: [:index]
  after_action :log_search, only: [:index]

  def index
      begin
        @location = GoogleGeocodingService.find_address(params[:address])
      rescue
        return external_api_error("Google Places")
      end
      begin
        trails = HikingProjectTrailService.get_trails(format_trail_params)
      rescue
        return external_api_error("Hiking Trails")
      end
      render json: trails, each_serializer: Api::V1::TrailSerializer, root: 'trails'
  end

  private

  attr_reader :location, :message

  def validate_address
    return render json: {errors: ['include address as param']}, status: :unprocessable_entity unless
      params[:address]
    return render json: {errors: ['format address like Denver, CO']}, status: :unprocessable_entity unless
      params[:address].match(/^[\w\s]+,\s\w{2}$/)
  end

  def external_api_error(api)
    render json: {message: "The #{api} API seems to be down"}, status: :service_unavailable
  end


  def format_trail_params
    trail_params.except(:address, :api_key).merge(lat:location['lat'], lon: location['lng'])
  end

  def trail_params
    params.permit(:address, :api_key, :maxDistance, :maxResults, :sort, :minLength, :minStars)
  end

  def log_search
    TrailSearchCreator.log_search(trail_params)
  end
end