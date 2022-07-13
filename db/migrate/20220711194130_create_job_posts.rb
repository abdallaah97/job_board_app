class CreateJobPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :job_posts do |t|
      t.string :title, :null => false
      t.string :description, :null => false
      t.datetime :expire_date

      t.timestamps
    end
  end
end
