class CreateEventResults < ActiveRecord::Migration[5.0]
  def change
    create_table :event_results do |t|
      t.integer :event_id
      t.string :job_id
      t.string :queue
      t.integer :attempts
      t.text :last_error
      t.integer :priority
      t.text :locked_by
      t.datetime :run_at
      t.datetime :failed_at

      t.timestamps
    end
    remove_column :events, :status
  end
end
