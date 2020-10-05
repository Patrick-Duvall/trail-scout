require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  
  describe 'create' do
    let(:email) {'duvallp208@gmail.com'}
    let(:other_email) {'duvallp209@gmail.com'}
    let(:password) {'password'}
    let(:other_password) {'bassword'}
    
    it 'creates a user with email, password, and password confirmation' do
      get :create, params: { email: email,
                            password: password,
                            password_confirmation: password
                          }
        expect(response.status).to eq(201)
        response = JSON.parse(response.body)
        expect(response[:user][:email]).to eq(email)
        expect(response[:user][:api_key]).to eq(User.last.api_key)
    end

    it 'requires matching password and password confirmation' do
      get :create, params: { email: email,
                            password: password,
                            password_confirmation: other_password
                          }
        expect(response.status).to eq(404)
    end

    context 'with an existing user' do

      before do
        User.create(email: email, password: password)
      end

      it 'cant make user with the same email' do
        get :create, params: { email: email,
                            password: other_password,
                            password_confirmation: other_password
                          }
        expect(response.status).to eq(422)
      end
      end
    end
  end
end