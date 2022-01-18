require 'rails_helper'

RSpec.describe 'users', type: :request do
  describe 'GET /users' do
    it 'works! returns correct status code' do
      get users_path
      expect(response).to have_http_status(:ok)
    end

    it 'works! renders index view correctly' do
      get users_path
      expect(response).to render_template(:index)
    end

    it 'works! reponse body includes Here the list of users ' do
      get users_path
      expect(response.body).to include 'Here the list of users'
    end
  end

  describe 'GET /users/:id' do
    it 'works! returns correct status code' do
      get user_path(1)
      expect(response).to have_http_status(:ok)
    end

    it 'works! renders show view correctly' do
      get user_path(1)
      expect(response).to render_template(:show)
    end

    it 'works! reponse body includes Here show user for given user' do
      get user_path(1)
      expect(response.body).to include 'Here show user for given user'
    end
  end
end
