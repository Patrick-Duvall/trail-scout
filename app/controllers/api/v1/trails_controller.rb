class Api::V1::TrailsController < ApplicationController

  before_action :validate_address, only: [:index]
  after_action :log_search, only: [:index]

  def index
    @location = GoogleGeocodingService.find_address(params[:address])
    # TODO cache location
    trails = HikingProjectTrailService.get_trails(format_trail_params)
    render json: trails, each_serializer: Api::V1::TrailSerializer, root: 'trails'
  end

  private

  attr_reader :location

  def validate_address
    return render json: {errors: ['include address as param']}, status: :unprocessable_entity unless
      params[:address]
    return render json: {errors: ['format address like Denver, CO']}, status: :unprocessable_entity unless
      params[:address].match(/^[\w\s]+,\s\w{2}$/)

  end

  def format_trail_params
    #TODO delete except?
    trail_params.except(:address).merge(lat:location['lat'], lon: location['lng'])
  end

  def trail_params
    params.permit(:address, :maxDistance, :maxResults, :sort, :minLength, :minStars)
  end

  def log_search
    TrailSearchCreator.log_search(trail_params)
  end
end