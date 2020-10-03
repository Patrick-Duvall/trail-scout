require 'rails_helper'

RSpec.describe GoogleGeocodingService do
  describe 'find_address' do

    before do
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Denver,%20CO&key=#{ENV['GOOGLE_PLACES_KEY']}")
        .to_return( body: file_fixture("google_geocoding_response.json").read)
    end

    it 'returns a lat and long' do
      location = described_class.find_address('Denver, CO')
      expect(location['lat']).to eq(39.7392358)
      expect(location['lng']).to eq(-104.990251)
    end
  end
end