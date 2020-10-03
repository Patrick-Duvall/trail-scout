require 'rails_helper'

RSpec.describe TrailSearchCreator do
  describe 'log_search' do

    it 'creates a trail search with given params' do
      params = {
        address: 'Denver, CO',
        maxResults: '1',
        maxDistance: '19',
        sort: '1',
        minLength: '2',
        minStars: '3',
      }

      trail_search = TrailSearchCreator.log_search(params)

      expect(trail_search.city).to eq('denver, co')
      expect(trail_search.max_results).to eq(1)
      expect(trail_search.sort).to eq('distance')
      expect(trail_search.min_length).to eq(2)
      expect(trail_search.min_stars).to eq(3)
    end
  end
end
