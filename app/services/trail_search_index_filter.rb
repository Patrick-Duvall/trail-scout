class TrailSearchIndexFilter

  def self.fetch_searches(params)
    new.fetch_searches(params)
  end

  def fetch_searches(params)
    binding.pry
    TrailSearch.where('city ILIKE ?', "%#{params[:city]}%")
  end

end