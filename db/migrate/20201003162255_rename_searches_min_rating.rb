class RenameSearchesMinRating < ActiveRecord::Migration[5.2]
  def change
    rename_column :searches, :min_rating, :min_stars
  end
end
