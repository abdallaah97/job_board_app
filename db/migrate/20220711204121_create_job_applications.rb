class CreateJobApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :job_applications do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.string :phone_number, :null => false
      t.string :linked_in, :null => true
      t.datetime :barth_date, :null => true
      t.string :address, :null => true
      t.string :cover_letter, :null => false
      t.boolean :is_seen, :null => false, :default => false
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :job_post, index: true, foreign_key: true
      t.timestamps
    end
  end
end
