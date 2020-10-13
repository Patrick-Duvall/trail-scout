class Api::V1::TrailSearchesController < ApplicationController
  def index
    searches = TrailSearchIndexFilter.fetch_searches(trail_search_params)
    render  json: searches,
            each_serializer: Api::V1::TrailSearchSerializer,
            meta: meta_attributes(searches)
  end

  private

  def trail_search_params
    params.permit(:city, :order, :direction, :sort, :limit, :page, :per_page)
  end
end