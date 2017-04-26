class AddDelayedJobIdToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :job_id, :integer
  end
end
