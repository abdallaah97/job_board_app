require 'swagger_helper'

RSpec.describe 'job_post', type: :request do

  let(:access_token) { FactoryBot.create(:api_key).access_token }
  let(:Authorization) { "Bearer #{access_token}" }

  path '/api/job_post/create_job_post' do

    post('create job post by admin only') do
      response(200, 'successful') do
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            description: { type: :string },
            expire_date: { type: :string, example: DateTime.now }
          }
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/job_post/update_job_post' do

    put('update job post by admin only') do
      response(200, 'successful') do
        security [Bearer: {}]
        parameter name: :job_post, in: :body, schema: {
          type: :object,
          properties: {
            id: { type: :integer },
            title: { type: :string },
            description: { type: :string },
            expire_date: { type: :string, example: DateTime.now }
          }
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/job_post/destroy_job_post/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'
    delete('destroy job post by admin only') do
      response(200, 'successful') do
        security [Bearer: {}]

        let(:id) { '123' }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/job_post/list_all_job_posts' do

    post('list all job posts (all post to the admin, filterd by expire date to the job seekers)') do
      response(200, 'successful') do
        security [Bearer: {}]
        parameter name: :job_post, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            created_at: { type: :string, example: DateTime.now },
          }
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
