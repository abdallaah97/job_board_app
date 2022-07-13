class JobApplicationMailer < ApplicationMailer
    def new_job_application_email
        @email = params[:email]
        @job_post_title = params[:job_post_title]
        mail(to: @email,
            subject: 'Your job application has been seen') do |format|
                format.text { render plain: "Your job application on job post '#{@job_post_title}' has been seen by the admin"}
       end
    end
end
