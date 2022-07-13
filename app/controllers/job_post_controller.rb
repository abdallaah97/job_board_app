class JobPostController < ApplicationController
    
    load_and_authorize_resource
    before_action :set_job_post, only: [:update_job_post, :destroy_job_post]
    
    def create_job_post
        @job_post_result = JobPost.create(job_post_params)
        if @job_post_result.save
            response = {
                is_successfully: true,
                message: "Job post created successfully",
                data: @job_post_result,
                errors: []
            }
            render json: response
        else
            response = {
                is_successfully: false,
                data: {},
                message: "Failed to create job post",
                errors: @job_post_result.errors.messages
            }
            render json: response
        end
    end

    def update_job_post
        if @job_post.update(job_post_params)
            response = {
                is_successfully: true,
                message: "Job post updated successfully",
                data: @job_post,
                errors: []
            }
            render json: response
        else
            response = {
                is_successfully: false,
                data: {},
                message: "Failed to updated job post",
                errors: @job_post.errors.messages
            }
            render json: response
        end
    end

    def list_all_job_posts
        begin
            @job_posts_result = JobPost.all
            if (!current_user.is_admin)
                @job_posts_result = @job_posts_result.filter_by_expire_date()
            end
            @job_posts_result = @job_posts_result.filter_by_creation_date(params[:created_at]) if params[:created_at].present?
            @job_posts_result = @job_posts_result.filter_by_title(params[:title]) if params[:title].present?
            @job_posts_result = @job_posts_result.order('created_at desc')
        
            response = {
                is_successfully: true,
                message: "Data has been retrieved successfully",
                data: @job_posts_result,
                errors: []
            }
            render json: response
        rescue => e
            response = {
                is_successfully: false,
                message: "Failed to retrieve data ",
                data: [],
                errors: e
            }
            render json: response
        end
    end

    def destroy_job_post
        begin
            @job_post.destroy
            response = {
                is_successfully: true,
                message: "Job post deleted successfully",
                data: {},
                errors: []
            }
            render json: response
        rescue => e
            response = {
                is_successfully: false,
                message: "Failed to delete job post",
                data: [],
                errors: e
            }
            render json: response
        end
    end

  private

    def set_job_post
      @job_post = JobPost.find(params[:id])
    end

    def job_post_params
      params.permit(
        :title, 
        :description, 
        :expire_date
    )
    end
end