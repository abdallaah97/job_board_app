require 'swagger_helper'

RSpec.describe 'auth', type: :request do

  path '/api/auth/register' do

    post('register auth') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            first_name: { type: :string },
            last_name: { type: :string },
            email: { type: :string },
            password: { type: :string }
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

  path '/api/auth/login' do

    post('login auth') do
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :user, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string, example: "admin@job_board.com" },
            password: { type: :string, example: "admin" }
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
