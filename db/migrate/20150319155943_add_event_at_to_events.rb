class AddEventAtToEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_at, :datetime
  end
end
