class ChangeColumnTypeAtEvents < ActiveRecord::Migration[5.0]
  def change
  	change_column :events, :at, :datetime
  end
end
