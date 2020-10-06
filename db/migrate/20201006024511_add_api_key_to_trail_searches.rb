class AddApiKeyToTrailSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :trail_searches, :api_key, :string
  end
end
