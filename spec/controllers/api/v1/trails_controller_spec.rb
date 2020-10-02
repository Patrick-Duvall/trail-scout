require 'rails_helper'

RSpec.describe Api::V1::TrailsController, type: :controller do
  before do

  end

  describe 'GET #index' do
    it 'returns 400 if no lat' do
      get :index, params: {lon: 104.9903}
      expect(response.status).to eq 400
    #   parse_json = JSON(response.body)
    end

    it 'returns 400 if no lon' do
      get :index, params: {lat: 39.7392}
      expect(response.status).to eq 400
    #   parse_json = JSON(response.body)
    end

    it 'returns by default 10 trails' do
      allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(file_fixture("hiking_trails_response.json"))
      get :index, params: {lat: 40.0274, lon: -105.2519}
      expect(response.body['trails']).to eq(10)
      response.body['trails'] do |trail|
          expect(trail.name)
          expect(trail.summary)
          expect(trail.url)
          expect(trail.location)
      end
    end
  end
end