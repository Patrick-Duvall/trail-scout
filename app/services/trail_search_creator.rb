class TrailSearchCreator

  def self.log_search(params)
    new.log_search(params)
  end

  def log_search(params)
    params[:city] = params.delete(:address).downcase
    TrailSearch.create(params)
  end

end