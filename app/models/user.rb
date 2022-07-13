class User < ApplicationRecord
    has_secure_password
    
    validates_presence_of :first_name, :last_name, :email, :password_digest
    validates :email, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

    has_many :job_applications
end
