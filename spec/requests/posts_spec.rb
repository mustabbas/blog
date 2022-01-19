require 'rails_helper'

RSpec.describe 'posts', type: :request do
  describe 'GET /posts' do
    it 'works! returns correct status code' do
      get user_posts_path(user_id: 1)
      expect(response).to have_http_status(:ok)
    end

    it 'works!  renders index view correctly' do
      get user_posts_path(user_id: 1)
      expect(response).to render_template(:index)
    end

    it 'works! reponse body includes Here is a list of posts for a given user' do
      get user_posts_path(user_id: 1)
      expect(response.body).to include 'Here is a list of posts for a given user'
    end
  end

  describe 'GET /posts/:id' do
    it 'works! returns correct status code' do
      get user_post_path(1, id: 1)
      expect(response).to have_http_status(:ok)
    end

    it 'works!  renders show view correctly' do
      get user_post_path(1, id: 1)
      expect(response).to render_template(:show)
    end

    it 'works! reponse body includes Here show post for a given use ' do
      get user_post_path(1, id: 1)
      expect(response.body).to include 'Here show post for a given use'
    end
  end
end
