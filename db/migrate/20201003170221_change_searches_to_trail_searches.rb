class ChangeSearchesToTrailSearches < ActiveRecord::Migration[5.2]
  def change
    rename_table :searches, :trail_searches
  end
end
