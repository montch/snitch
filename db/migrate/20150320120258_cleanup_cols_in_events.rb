class CleanupColsInEvents < ActiveRecord::Migration
  def change
remove_column :events, :payload
remove_column :events, :comment
  end
end
