class Api::V1::User::TrailSearchesController < ApplicationController

  before_action :validate_api_key, only: [:index]

  def index
    searches = TrailSearchIndexFilter.fetch_searches(trail_search_params)
    render json: searches, each_serializer: Api::V1::TrailSearchSerializer
  end

  private

  def trail_search_params
    params.permit(:api_key)
  end

end