class TrailSearchIndexFilter

  def self.fetch_searches(params)
    new.fetch_searches(params)
  end

  def fetch_searches(params)
    @params = params
    TrailSearch.where(search_params)
      .order("#{order} #{direction} NULLS LAST")
      .limit(limit)
  end

  private

  attr_reader :params

  def search_params
    params.except(:order, :direction, :limit)
  end

  def order
    params[:order] || 'created_at'
  end

  def limit
    params[:limit] || 10
  end

  def direction
    %w(desc DESC).include?(params[:direction]) ? params[:direction] : 'ASC'
  end
end
