class TrailSearchIndexFilter

  def self.fetch_searches(params)
    new.fetch_searches(params)
  end

  def fetch_searches(params)
    @params = params
    TrailSearch.where('city ILIKE ?', "%#{params[:city]}%")
    .order("#{order} #{direction}")
    # .where('sort ILIKE ?', "%#{params[:sort_type]}%")
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

# @params = params
#     params[:sort] = params.delete(:filter)
