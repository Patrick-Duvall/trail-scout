class TrailSearchIndexFilter

  def self.fetch_searches(params)
    new.fetch_searches(params)
  end

  def fetch_searches(params)
    @params = params
    TrailSearch.where('city ILIKE ?', "%#{params[:city]}%")
      .order("#{params[:sort] || 'created_at'} #{direction}")
  end

  private

  attr_reader :params

  def direction
    %w(desc DESC).include?(params[:direction]) ? params[:direction] : 'ASC'
  end
end
