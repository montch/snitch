class AddCallerToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :caller, :string
  end
end
