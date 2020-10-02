class Api::V1::TrailsController < ApplicationController

  before_action :validate_address, only: [:index]

  def index
    @location = GoogleGeocodingService.find_address(params[:location])
    trails = HikingProjectTrailService.get_trails(format_trail_params)
    render json: trails, each_serializer: Api::V1::TrailSerializer, root: 'trails'
  end

  private

  attr_reader :location

  def validate_address
    render json: {errors: ['include address as param']}, status: :unprocessable_entity unless
      params[:address]
  end

  def format_trail_params
    trail_params.except(:address).merge(lat:location['lat'], lon: location['lng'])
  end

  def trail_params
    params.permit(:address, :maxDistance, :maxResults, :sort, :minLength, :minStars)
  end
end