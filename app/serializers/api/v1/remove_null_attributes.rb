module Api::V1::RemoveNullAttributes
  def attributes(*args)
    super.compact
  end
end