require 'rails_helper'

RSpec.describe 'posts', type: :request do
  describe 'GET /posts' do
    before(:example) { get '/users/10/posts' }
    it 'works! returns correct status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'works!  renders index view correctly' do
      expect(response).to render_template(:index)
    end

    it 'works! reponse body includes Bio' do
      expect(response.body).to include 'Bio'
    end
  end

  describe 'GET /posts/:id' do
    before(:example) { get '/users/10/posts/20' }
    it 'works! returns correct status code' do
      expect(response).to have_http_status(:ok)
    end

    it 'works!  renders show view correctly' do
      expect(response).to render_template(:show)
    end

    it 'works! reponse body includes by ' do
      expect(response.body).to include 'by'
    end
  end
end
