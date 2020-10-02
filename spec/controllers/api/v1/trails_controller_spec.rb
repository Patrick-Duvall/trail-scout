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
      get :index, params: {lat: 39.7392, lon: 104.9903}
      binding.pry
      expect(response.body.count).to eq(10)
      response.body.each do |response|
          expect(response.trail_name)
          expect(response.website)
      end
    end
  end
end