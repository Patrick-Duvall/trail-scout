require 'rails_helper'

RSpec.describe Api::V1::TrailSearchesController, type: :controller do

  describe 'GET #index' do
    it 'returns 200' do
      get :index, params: {}
      expect(response.status).to eq(200)
    end

    it 'returns all trails by default' do
      FactoryBot.create_list(:trail_search, 2)
      get :index, params: {}
    end
  end

end