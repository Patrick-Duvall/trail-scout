require 'rails_helper'

RSpec.describe Api::V1::CompanyInvitationsController, type: :controller do
  before do

  end

  describe 'GET #index' do
    it 'returns 200 client' do
      get :index
      expect response.to eq 200
    #   parse_json = JSON(response.body)
    end
  end
end
