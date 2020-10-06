require 'rails_helper'

RSpec.describe TrailSearchCreator do
  describe 'log_search' do
    describe 'with a user with the same api_key' do
      let!(:user) { User.create(email: 'pat@gmail.com', password: 'goodword')}

      it 'creates a trail search with given params' do
        params = {
          address: 'Denver, CO',
          maxResults: '1',
          maxDistance: '19',
          sort: 'distance',
          minLength: '2',
          minStars: '3',
          api_key: user.api_key
        }

        trail_search = TrailSearchCreator.log_search(params)

        expect(trail_search.city).to eq('denver, co')
        expect(trail_search.max_results).to eq(1)
        expect(trail_search.sort).to eq('distance')
        expect(trail_search.min_length).to eq(2)
        expect(trail_search.min_stars).to eq(3)
        expect(trail_search.user).to eq(user)
      end
    end
  end
end
