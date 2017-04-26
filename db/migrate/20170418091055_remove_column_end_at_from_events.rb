class RemoveColumnEndAtFromEvents < ActiveRecord::Migration[5.0]
  def change
  	remove_column :events, :end_at
  end
end
