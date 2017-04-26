class AddPriorityToEvents < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :priority, :integer, :default => 10
  end
end
