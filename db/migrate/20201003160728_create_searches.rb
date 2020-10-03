class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :city
      t.integer :max_distance
      t.integer :max_results
      t.integer :sort
      t.integer :min_length
      t.integer :min_rating
    end
  end
end
