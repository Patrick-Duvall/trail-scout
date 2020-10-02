class Trail
  include ActiveModel::Serialization
  def initialize(attributes)
    @name = attributes['name']
    @summary = attributes['summary']
    @location = attributes['location']
    @url = attributes['url']
  end

  attr_reader :name, :summary, :location, :url
end
