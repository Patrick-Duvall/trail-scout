class AddTimeStampsToTrailSearches < ActiveRecord::Migration[5.2]
  def change
    add_timestamps :trail_searches, null: false, default: -> { 'NOW()' }
  end
end
