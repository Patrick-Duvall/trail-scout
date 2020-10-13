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
      expect(JSON.parse(response.body).count).to eq(2)
    end

    it 'paginates data' do
      FactoryBot.create_list(:trail_search, 15)
      get :index, params: {page:3, per_page: 5}
      response_info = JSON.parse(response.body)
      expect(response_info['trail_searches'].count).to eq(5)
      expect(response_info['meta']['total_entries']).to eq(15)
      expect(response_info['meta']['current_page']).to eq(3)
      expect(response_info['meta']['previous_page']).to eq(2)
      expect(response_info['meta']['next_page']).to eq(nil)
    end

    it 'defaults to page 1, page_limit 10' do
      FactoryBot.create_list(:trail_search, 15)
      get :index, params: {}
      response_info = JSON.parse(response.body)
      expect(response_info['trail_searches'].count).to eq(10)
      expect(response_info['meta']['total_entries']).to eq(15)
      expect(response_info['meta']['current_page']).to eq(1)
      expect(response_info['meta']['previous_page']).to eq(nil)
      expect(response_info['meta']['next_page']).to eq(2)
    end
  end
end