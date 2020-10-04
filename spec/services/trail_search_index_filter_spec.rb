require 'rails_helper'

RSpec.describe Api::V1::TrailSearchIndexFilter
  describe '.fetch_searches' do
    before do
      search_1 = FactoryBot.create( #middle values for sort
        :trail_search,
        city: 'lipton, mo',
        max_distance: 15,
        max_results: 2,
        sort: 'distance',
        min_length: 2,
        min_stars: 3
      )
      search_2 = FactoryBot.create( #lowest values for sort
        :trail_search,
        city: 'lipton, mo',
        max_distance: 10,
        max_results: 1,
        sort: 'quality',
        min_length: 1,
        min_stars: 2
      )
      search_3 = FactoryBot.create( #highest values for sort
        :trail_search,
        city: 'lipton, mo',
        max_distance: 20
        max_results: 3,
        sort: 'quality',
        min_length: 3,
        min_stars: 4
      )
    end

    it 'filters on a city name' do
      searches = described_class.fetch_searches(city: 'lip')
      expect(searches.count).to eq(2)
      expect(searches).to_include [search_1, search_2]
    end

    it 'sorts searches by max_distance' do
      searches = described_class.fetch_searches(sort: 'max_distance')
      expect(searches).to_eq [search_2, search_1, search_3]
    end

    it 'sorts searches by max_results' do
      searches = described_class.fetch_searches(sort: 'max_results')
      expect(searches).to_eq [search_2, search_1, search_3]
    end

    xit 'sorts searches by searches sort type' do
      searches = described_class.fetch_searches(sort: 'max_distance')
      expect(searches).to_eq [search_2, search_1, search_3]
    end

    it 'sorts searches by min_length' do
      searches = described_class.fetch_searches(sort: 'min_length')
      expect(searches).to_eq [search_2, search_1, search_3]
    end

    it 'sorts searches by min_stars' do
      searches = described_class.fetch_searches(sort: 'min_length')
      expect(searches).to_eq [search_2, search_1, search_3]
    end
  end

end