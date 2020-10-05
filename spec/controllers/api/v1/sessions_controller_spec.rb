require 'rails_helper'

RSpec.describe Api::V1::SessionsController do
  
  describe 'create' do
    let(:email) {'duvallp208@gmail.com'}
    let(:password) {'password'}
    let(:other_email) {'duvallp208@gmail.com'}
    let(:other_password) {'password'}
    let!(:user) { User.create!(email: email, password: password) }

    it 'returns a users api key when given a valid email and pw' do
      get :create, params: { email: email, password: password}
      response = JSON.parse(response.body)
      expect(response['api_key']).to eq(User.last.api_key)
    end

    it 'returns 404 if email not found' do
      get :create, params: { email: other_email, password: password}
      expect(response.status).to eq(404)
    end

    it 'returns 404 if invalid password' do
      get :create, params: { email: email, password: other_password}
      expect(response.status).to eq(404)
    end
  end
end
