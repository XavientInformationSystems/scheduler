class RelocateStatusFromEventsToResults < ActiveRecord::Migration[5.0]
  def change
  	remove_column :events, :status, :string
  	add_column :event_results, :status, :string, :default => "Pending"
  end
end
