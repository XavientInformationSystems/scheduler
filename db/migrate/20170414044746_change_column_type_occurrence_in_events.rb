class ChangeColumnTypeOccurrenceInEvents < ActiveRecord::Migration[5.0]
  def change
  	change_column :events, :occurrence, :string
  end
end
