require 'rails_helper'

RSpec.describe Api::V1::TrailsController, type: :controller do

  describe 'GET #index' do

    let(:api_key) { User.create(email: 'pat@gmail.com', password: 'goodword').api_key }

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
      
      it 'returns a 200 if invalid params provided' do
        get :index, params: {address: 'Denver, CO', chowder: 'yummy', api_key: api_key}
        expect(response.status).to eq 200
      end

      context 'with no api_key' do
        it 'returns 422' do
          get :index, params: {address: 'Denver, CO'}
          expect(response.status).to eq 422
          error = JSON.parse(response.body)['errors']
          expect(error).to eq(['Please provide an api_key'])
        end
      end

      context 'with bad api_key' do
        it 'returns 422' do
          get :index, params: {address: 'Denver, CO', api_key: 'nogood'}
          expect(response.status).to eq 422
          error = JSON.parse(response.body)['errors']
          expect(error).to eq(['Invalid api_key'])
        end
      end
      
      context 'with address and api_key provided' do
        it 'returns a 200' do
          get :index, params: {address: 'Denver, CO', api_key: api_key}
          expect(response.status).to eq 200
        end

        it 'returns 10 trails' do
          get :index, params: {address: 'Denver, CO', api_key: api_key}
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
          expect(TrailSearchCreator).to receive(:log_search).with({"address"=>"Denver, CO", 'api_key' => api_key})
          get :index, params: {address: 'Denver, CO', api_key: api_key}
        end
    end

  #  before do
  #   allow_any_instance_of(Object).to receive(:foo).and_return(:return_value)
  # end

    context 'when Google API service is down' do
      it 'returns a 503' do
        stub_request(:get, "https://maps.googleapis.com/maps/api/geocode/json?address=Denver,%20CO&key=#{ENV['GOOGLE_PLACES_KEY']}")
          .to_return( body: nil)
        get :index, params: {address: 'Denver, CO', api_key: api_key}
        expect(response.status).to eq(503)
        expect(JSON.parse(response.body)).to eq({'message' =>'The Google Places API seems to be down'})
      end
    end

    context 'when HikingProject API service is down' do
      it 'returns a 503' do
        stub_request(:get, "https://www.hikingproject.com/data/get-trails?lat=39.7392358&lon=-104.990251&key=#{ENV['HIKING_TRAILS_KEY']}")
          .to_return( body: nil)
        get :index, params: {address: 'Denver, CO', api_key: api_key}
        expect(response.status).to eq(503)
        expect(JSON.parse(response.body)).to eq({ 'message' =>'The Hiking Trails API seems to be down' })
      end
    end
  end
end