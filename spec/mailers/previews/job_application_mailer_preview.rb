# Preview all emails at http://localhost:3000/rails/mailers/job_application_mailer
class JobApplicationMailerPreview < ActionMailer::Preview
    def new_job_application_email
        # Set up a temporary order for the preview
        JobApplicationMailer.with(email: "a.maraebah@e-incube.com", job_post_title: "job_post_title_test").new_job_application_email
      end
end
