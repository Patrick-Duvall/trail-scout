require 'rails_helper'

RSpec.describe TrailSearchIndexFilter do
  describe '.fetch_searches' do
    let!(:search_1) do FactoryBot.create( #middle values for sort
      :trail_search,
      city: 'lipton, mo',
      max_distance: 15,
      max_results: 2,
      sort: 'distance',
      min_length: 2,
      min_stars: 3)
    end
    let!(:search_2) do FactoryBot.create( #lowest values for sort
      :trail_search,
      city: 'lipland, mo',
      max_distance: 10,
      max_results: 1,
      sort: 'quality',
      min_length: 1,
      min_stars: 2)
    end
    let!(:search_3) do FactoryBot.create( #highest values for sort
      :trail_search,
      city: 'loveland, co',
      max_distance: 20,
      max_results: 3,
      sort: 'quality',
      min_length: 3,
      min_stars: 4)
    end

    it 'filters on a city name' do
      searches = described_class.fetch_searches(city: 'lip')
      expect(searches.count).to eq(2)
      expect(searches).to include(search_1, search_2)
    end

    it 'filters on quality' do
      searches = described_class.fetch_searches(filter: 'quality')
      expect(searches).to eq([search_2, search_3])
    end

    it 'filters on distance' do
      searches = described_class.fetch_searches(filter: 'distance')
      expect(searches).to eq([search_1])
    end

    it 'sorts searches by max_distance' do
      searches = described_class.fetch_searches(order: 'max_distance')
      expect(searches).to eq([search_2, search_1, search_3])
    end

    it 'sorts searches by max_results' do
      searches = described_class.fetch_searches(order: 'max_results')
      expect(searches).to eq([search_2, search_1, search_3])
    end

    it 'sorts searches by min_length' do
      searches = described_class.fetch_searches(order: 'min_length')
      expect(searches).to eq([search_2, search_1, search_3])
    end

    it 'sorts searches by min_stars' do
      searches = described_class.fetch_searches(order: 'min_stars')
      expect(searches).to eq([search_2, search_1, search_3])
    end

    context 'when passed a direction desc' do
      it 'sorts searches by max_distance' do
        searches = described_class.fetch_searches(order: 'max_distance', direction: 'desc')
        expect(searches).to eq([search_3, search_1, search_2])
      end

      it 'sorts searches by max_results' do
        searches = described_class.fetch_searches(order: 'max_results', direction: 'desc')
        expect(searches).to eq([search_3, search_1, search_2])
      end

      it 'sorts searches by min_length' do
        searches = described_class.fetch_searches(order: 'min_length', direction: 'desc')
        expect(searches).to eq([search_3, search_1, search_2])
      end

      it 'sorts searches by min_stars' do
        searches = described_class.fetch_searches(order: 'min_length', direction: 'desc')
        expect(searches).to eq([search_3, search_1, search_2])
      end
    end
  end
end