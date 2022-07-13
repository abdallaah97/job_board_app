class JobApplicationController < ApplicationController

    load_and_authorize_resource

    def create_job_application
        @job_application_result = JobApplication.create(job_application_params)
        @job_application_result.user_id = current_user.id
        if @job_application_result.save
            response = {
                is_successfully: true,
                message: "Job application created successfully",
                data: @job_application_result,
                errors: []
            }
            render json: response
        else
            response = {
                is_successfully: false,
                data: {},
                message: "Failed to create job application",
                errors: @job_application_result.errors.messages
            }
            render json: response
        end
    end

    def list_job_applications_by_job_post
        begin
            @job_applications_data = JobApplication.all.includes(:user)
            @job_applications_data = @job_applications_data.filter_by_job_post(params[:job_post_id])
            @job_applications_data = @job_applications_data.order('created_at')

            if(current_user.is_admin)
                # update job applications status
                @job_applications_data.update_all(is_seen: true)
            end

            

            @job_applications_result = []
            @job_applications_data.each do |record|
                @job_applications_result.push({
                    id: record.id,
                    full_name: "#{record.first_name} #{record.last_name}",
                    email: record.email,
                    phone_number: record.phone_number,
                    linked_in: record.linked_in,
                    barth_date: record.barth_date,
                    cover_letter: record.cover_letter,
                    created_at: record.created_at,
                    is_seen: record.is_seen,
                    user: {
                        id: record.user_id,
                        full_name: "#{record.user.first_name} #{record.user.last_name}"
                    }
                })
                JobApplicationMailer.with(email: record.email, job_post_title: record.job_post.title).new_job_application_email.deliver_now
            end
            response = {
                is_successfully: true,
                message: "Data has been retrieved successfully",
                data: @job_applications_result,
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
    private

    def job_application_params
      params.permit(
        :first_name, 
        :last_name, 
        :email,
        :phone_number, 
        :linked_in, 
        :barth_date,
        :address, 
        :cover_letter,
        :job_post_id
    )
    end
end
