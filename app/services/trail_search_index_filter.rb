class TrailSearchIndexFilter

  def self.fetch_searches(params)
    new.fetch_searches(params)
  end

  def fetch_searches(params)
    @params = params
    TrailSearch.where(params.except(:order, :direction))
      .order("#{order} #{direction}")
    
  end

  private

  attr_reader :params

  def order
    params[:order] || 'created_at'
  end

  def direction
    %w(desc DESC).include?(params[:direction]) ? params[:direction] : 'ASC'
  end
end
