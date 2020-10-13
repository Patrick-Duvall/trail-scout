class TrailSearchIndexFilter

  PAGE_NUMBER = 1
  RESULTS_PER_PAGE = 10

  def self.fetch_searches(params)
    new.fetch_searches(params)
  end

  def fetch_searches(params)
    @params = params
    trails = TrailSearch.where(search_params)
      .order("#{order} #{direction} NULLS LAST")
      .limit(limit)
      paginate_results(trails, params[:page], params[:per_page])
  end

  private

  attr_reader :params

# could extract to module
  def paginate_results(active_record_relation, page, per_page)
    active_record_relation.paginate(
      page: page || PAGE_NUMBER,
      per_page: per_page || RESULTS_PER_PAGE
    )
  end

  def search_params
    params.except(:order, :direction, :limit, :page, :per_page)
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
