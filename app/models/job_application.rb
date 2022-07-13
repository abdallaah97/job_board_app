class JobApplication < ApplicationRecord
    validates_presence_of :first_name, :last_name, :email, :phone_number, :cover_letter, :job_post_id, :user_id
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

    belongs_to :user
    belongs_to :job_post

    scope :filter_by_job_post, -> (job_post_id) { where("job_post_id = ?", "#{job_post_id}")}
end
