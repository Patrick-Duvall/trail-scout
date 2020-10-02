class Api::V1::TrailsController < ApplicationController

  before_action :validate_lat_lon, only: [:index]

  def index
    trails = HikingProjectTrailService.get_trails(trail_params)
    binding.pry 
    render json: trails, each_serializer: Api::V1::TrailSerializer, root: 'trails'
  end

  private

  def validate_lat_lon
    render json: {errors: ['include lat and lon as params']}, status: :bad_request unless
      params[:lat] && params[:lon]
  end

  def trail_params
    params.permit(:lat, :lon, :maxDistance, :maxResults, :sort, :minLength, :minStars)
  end
end