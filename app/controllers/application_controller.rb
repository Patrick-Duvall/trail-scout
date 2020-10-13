class ApplicationController < ActionController::API

  def validate_api_key
    return render json: {errors: ['Please provide an api_key']}, status: :unprocessable_entity unless
      params[:api_key]
    return render json: {errors: ['Invalid api_key']}, status: :unprocessable_entity unless
      User.find_by(api_key: params[:api_key])
  end

  def meta_attributes(collection, extra_meta = {})
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      previous_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_entries: collection.total_entries
    }.merge(extra_meta)
  end

end
