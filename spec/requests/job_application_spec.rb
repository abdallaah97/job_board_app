require 'swagger_helper'

RSpec.describe 'job_application', type: :request do

  let(:access_token) { FactoryBot.create(:api_key).access_token }
  let(:Authorization) { "Bearer #{access_token}" }

  path '/api/job_application/create_job_application' do

    post('create_job_application job_application') do
      response(200, 'successful') do
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :job_application, in: :body, schema: {
          type: :object,
          properties: {
            first_name: { type: :string },
            last_name: { type: :string },
            email: { type: :string },
            phone_number: { type: :string },
            linked_in: { type: :string },
            barth_date: { type: :string, example: (DateTime.now - 18.year) },
            address: { type: :string },
            cover_letter: { type: :string },
            job_post_id: { type: :integer }
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

  path '/api/job_application/list_job_applications_by_job_post/{job_post_id}' do
    # You'll want to customize the parameter types...
    parameter name: 'job_post_id', in: :path, type: :string, description: 'job_post_id'

    get('list_job_applications_by_job_post job_application') do
      response(200, 'successful') do
        security [Bearer: {}]

        let(:job_post_id) { '123' }

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
