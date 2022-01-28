require 'rails_helper'

RSpec.describe 'users', type: :request do
  describe 'GET /users' do
    before(:example) { get '/users' }
    it 'works! returns correct status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'works! renders index view correctly' do
      expect(response).to render_template(:index)
    end

    it 'works! reponse body includes Number of posts  ' do
      expect(response.body).to include 'Number of posts '
    end
  end

  describe 'GET /users/:id' do
    before(:example) { get '/users/1' }
    it 'works! returns correct status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'works! renders show view correctly' do
      expect(response).to render_template(:show)
    end

    it 'works! reponse body includes comments' do
      expect(response.body).to include 'comments'
    end
  end
end
