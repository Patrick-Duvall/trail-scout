class AddTimesPerformedToTrailSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :trail_searches, :times_performed, :integer, default: 1, null: false
  end
end
