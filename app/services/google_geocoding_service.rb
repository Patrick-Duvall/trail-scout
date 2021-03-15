class GoogleGeocodingService

  def self.find_address(location)
    new.find_address(location)
  end

  def find_address(location)
    location_data = conn.get('/maps/api/geocode/json') do |req|
      req.params['key'] = ENV['GOOGLE_PLACES_KEY']
      req.params['address'] = location
    end
    JSON.parse(location_data.body)['results'].first['geometry']['location']    
  end

private
  def conn
    Faraday.new("https://maps.googleapis.com") do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end
end
