class AddNullConstraintCityToTrailSearches < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:trail_searches, :city, false)
  end
end
