class Api::V1::TrailSearchesController < ApplicationController

  def index
    searches = TrailSearchIndexFilter.fetch_searches(params)
    render json: searches, each_serializer: Api::V1::TrailSearchSerializer
  end

end