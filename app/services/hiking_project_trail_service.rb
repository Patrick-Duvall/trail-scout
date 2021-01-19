class HikingProjectTrailService

  CLIENT =  Faraday.new("https://www.hikingproject.com") do |faraday|
              faraday.adapter  Faraday.default_adapter
            end

  def self.get_trails(params, connection=CLIENT)
    new.get_trails(params.merge(key: ENV['HIKING_TRAILS_KEY']))
  end

  def get_trails(params)
    trail_data = connection.get('data/get-trails') do |req|
        req.params = params
    end
    trails = JSON.parse(trail_data.body)['trails']
    return [] unless trails
    trails.map{|trail_details| Trail.new(trail_details)}
  end
end
