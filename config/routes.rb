Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  post '/api/auth/register', to: 'auth#register'
  post '/api/auth/login', to: 'auth#login'

  post '/api/job_post/create_job_post', to: 'job_post#create_job_post'
  put '/api/job_post/update_job_post', to: 'job_post#update_job_post'
  delete '/api/job_post/destroy_job_post/:id(.:format)', to: 'job_post#destroy_job_post'
  post '/api/job_post/list_all_job_posts', to: 'job_post#list_all_job_posts'

  post '/api/job_application/create_job_application', to: 'job_application#create_job_application'
  get '/api/job_application/list_job_applications_by_job_post/:job_post_id(.:format)', to: 'job_application#list_job_applications_by_job_post'

end
