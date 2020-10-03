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
      expect(trail_search.times_performed).to eq(1)
    end

    context 'when the same search is performed twice' do
      before do
        params_1 = { address: 'Denver, CO', maxResults: '1' }
        params_2 = { address: 'Denver, CO', maxResults: '1' }
        TrailSearchCreator.log_search(params_1)
        TrailSearchCreator.log_search(params_2)
      end

      it 'will not create the same search twice' do
        expect(TrailSearch.count).to eq(1)
      end

      it 'increases a searches count by one' do
        expect(TrailSearch.last.times_performed).to eq(2)
      end
    end
    
    context 'when a search with some overlap is performed' do
      before do
        params_1 = {address: 'Denver, CO', maxResults: '1'}
        params_2 = {address: 'Denver, CO', maxResults: '2'}
        TrailSearchCreator.log_search(params_1)
        TrailSearchCreator.log_search(params_2)
      end

      xit 'creates two different searches' do
        
      end
    end
  end
end
