class AddFrequencyToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :frequency, :string, :default =>""
  	add_column :events, :execution_time, :text
  	add_column :events, :end_at, :datetime
  end
end
