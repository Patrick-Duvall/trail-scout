class HikingProjectTrailService

  def self.get_trails(params)
    new.get_trails(params.merge(key: ENV['HIKING_TRAILS_KEY']))
  end

  def get_trails(params)
    binding.pry
    trails = conn.get('data/get_trails') do |req|
        req.params = params
    end
    binding.pry
  end

private
  def conn
    Faraday.new("https://www.hikingproject.com") do |faraday|
      faraday.adapter  Faraday.default_adapter
    end
  end
end