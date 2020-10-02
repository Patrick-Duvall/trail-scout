class HikingProjectTrailService

  def self.get_trails(params)
    new.get_trails(params.merge(key: ENV['HIKING_TRAILS_KEY']))
  end

  def get_trails(params)
    trail_data = conn.get('data/get-trails') do |req|
        req.params = params
    end
    binding.pry
    trails = JSON.parse(trail_data.body)['trails']
    trails.map{|trail_details| Trail.new(trail_details)}
  end

private
  def conn
    Faraday.new("https://www.hikingproject.com") do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end
end
