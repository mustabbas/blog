require 'swagger_helper'

describe 'Blog API' do

  path '/users/:user_id/posts/:id' do

    post 'Creates a post' do
      tags 'Posts'
      consumes 'application/json', 'application/xml'
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          text: { type: :string },
          user_id: { type: :string },
          comments_counter: { type: :string },
          like_counter: { type: :string }
        },
        required: [ 'title', 'comments_counter', 'like_counter' ]
      }

      response '201', 'Post created' do
        let(:post) { { title: 'Post No. 1', text: 'This text of the post', user_id: '0', comments_counter: 0, likes_counter: 0} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:post) { { title: 'some thing' } }
        run_test!
      end
    end
  end

  path '/users/:user_id/posts/:post_id/comments/new' do

    post 'Creates a comment' do
      tags 'Posts'
      consumes 'application/json', 'application/xml'
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          text: { type: :string },
          user_id: { type: :string },
          post_id: { type: :string },
        }
      }

      response '201', 'Post created' do
        let(:comment) { {  text: 'This text of the comment', user_id: '0', post_id: '0'} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:comment) { { text: 'some thing' } }
        run_test!
      end
    end


    path '/users' do

        post 'Creates a user' do
          tags 'Users'
          consumes 'application/json', 'application/xml'
          parameter name: :post, in: :body, schema: {
            type: :object,
            properties: {
              name: { type: :string },
              email: { type: :string },
              password: { type: :string },
              bio: { type: :string },
              photo: { type: :string },
              posts_counter: { type: :number },
              password_confirmation: { type: :number }
            },
            required: [ 'name', 'post_counter' ]
          }
    
          response '201', 'Post created' do
            let(:user) { {  bane: 'User name', email: 'email@exmaple.com', password: '123456', bio: 'bio', photo: 'photo', posts_counter: 0, password_confirmation: '123456'} }
            run_test!
          end
    
          response '422', 'invalid request' do
            let(:user) { { name: 'some thing' } }
            run_test!
          end
        end
  end

  path '/users' do

    post 'Login' do
      tags 'Users'
      consumes 'application/json', 'application/xml'
      parameter name: :post, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
        }
      }

      response '201', 'Post created' do
        let(:user) { { email: 'email@exmaple.com', password: '123456'} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'some thing' } }
        run_test!
      end
    end
end



path '/users' do

    delete 'Login' do
      tags 'Users'
      consumes 'application/json', 'application/xml'
      parameter name: :delete, in: :body, schema: {
        type: :object,
        properties: {
        }
      }

      response '201', 'Post created' do
        let(:user) { { header: 'Authorization: Bearers 023094023980428502385028305203850238502398'} }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { header: 'Authorization: Bearers 023094023980428502385028305203850238502398'} }
        run_test!
      end
    end
end

  path '/users/:id/posts' do

    get 'Posts' do
      tags 'Posts'
      produces 'application/json', 'application/xml'
      parameter id: :id, :in => :path, :type => :string

      response '200', 'posts found' do
        schema type: :object,
          properties: {
            title: { type: :string },
            text: { type: :string },
            user_id: { type: :string },
            comments_counter: { type: :string },
            like_counter: { type: :string }
          },
          required: [ 'title', 'comments_counter', 'like_counter' ]

        let(:id) { Post.create(title: 'foo', text: 'bar', user_id: '0', comments_couter: 0, like_counter: 0).id }
        run_test!
      end

      response '404', 'pet not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end
  end

end
end