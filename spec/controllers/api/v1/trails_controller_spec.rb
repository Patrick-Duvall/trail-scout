require 'rails_helper'

RSpec.describe Api::V1::TrailsController, type: :controller do

  describe 'GET #index' do
    before do
      stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Denver,%20CO&key=#{ENV['GOOGLE_PLACES_KEY']}")
        .to_return( body: file_fixture("google_geocoding_response.json").read)
      stub_request(:get, "https://www.hikingproject.com/data/get-trails?lat=39.7392358&lon=-104.990251&key=#{ENV['HIKING_TRAILS_KEY']}")
        .to_return( body: file_fixture("hiking_trails_response.json").read)
      end
      
      it 'returns 422 if no address' do
        get :index, params: {}
        expect(response.status).to eq 422
      end
      
      it 'ignores invalid params' do
        get :index, params: {address: 'Denver, CO', chowder: 'yummy'}
        expect(response.status).to eq 200
      end
      
      context 'with address provided' do

        before do
          get :index, params: {address: 'Denver, CO'}
        end
        
        it 'returns a 200' do
          expect(response.status).to eq 200
        end

      it 'returns 10 trails' do
        trails = JSON.parse(response.body)
        expect(trails.count).to eq(10)
        trails.each do |trail|
            expect(trail['name']).to be_a(String)
            expect(trail['summary']).to be_a(String)
            expect(trail['url']).to be_a(String)
            expect(trail['location']).to be_a(String)
        end
      end

      it 'logs a trail search' do
        expect(TrailSearch.count).to have_increase_by(1)
      end
    end
  end
end