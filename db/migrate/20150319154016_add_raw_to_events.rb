class AddRawToEvents < ActiveRecord::Migration
  def change
    add_column :events, :raw, :json
  end
end
