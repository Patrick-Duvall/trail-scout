require 'rails_helper'

RSpec.describe HikingProjectTrailService do
  describe 'get_trails_address' do

    before do
      stub_request(:get, "https://www.hikingproject.com/data/get-trails?lat=39.7392358&lon=-104.990251&key=#{ENV['HIKING_TRAILS_KEY']}")
        .to_return( body: file_fixture("hiking_trails_response.json").read)
    end

    it 'returns an array of trails' do
      trails = described_class.get_trails( { lat:39.7392358, lon: -104.990251 } )
      expect(trails.count).to eq(10)
      trails.each do |trail|
        expect(trail).to be_a(Trail)
      end
    end
  end
end
