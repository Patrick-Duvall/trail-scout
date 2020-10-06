require 'rails_helper'

RSpec.describe Api::V1::Users::TrailSearchesController, type: :controller do

  describe 'GET #index' do

    let(:user) {FactoryBot.create(:user)}

    it 'returns 200' do
      get :index, params: {api_key: user.api_key}
      expect(response.status).to eq(200)
    end

    it 'returns all trails for a user by default' do
      FactoryBot.create_list(:trail_search, 2, user: user)
      get :index, params: {api_key: user.api_key}
      searches = JSON.parse(response.body)
      expect(searches.count).to eq(2)
    end
  end

end