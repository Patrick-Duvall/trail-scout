class Trail
  include ActiveModel::Serialization
  def initialize(attributes)
    @name = attributes['name']
    @summary = attributes['summary']
    @location = attributes['location']
    @url = attributes['url']
    @length = attributes['length']
    @stars = attributes['stars']
    @distance = attributes['distance']
  end

  attr_reader :name, :summary, :location, :url, :length, :stars, :distance
end
