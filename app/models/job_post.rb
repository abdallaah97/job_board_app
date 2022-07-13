class JobPost < ApplicationRecord
    validates_presence_of :title, :description
    has_many :job_applications
    
    scope :filter_by_expire_date, -> () { where("expire_date is null or expire_date > ?", "#{DateTime.now}")}
    scope :filter_by_creation_date, -> (created_at) { where("strftime('%Y-%m-%d', created_at) = ?", "#{Date.parse(created_at)}")}
    scope :filter_by_title, -> (title) { where("title like ?", "%#{title}%")}
end
