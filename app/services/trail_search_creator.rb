class TrailSearchCreator

  def self.log_search(params)
    new.log_search(params)
  end

  def log_search(params)
    params[:city] = params.delete(:address).downcase
    params[:max_results] = params.delete(:maxResults)&.to_i
    params[:max_distance] = params.delete(:maxDistance)&.to_i
    params[:min_length] = params.delete(:minLength)&.to_i
    params[:min_stars] = params.delete(:minStars)&.to_i
    TrailSearch.create(params)
  end

end