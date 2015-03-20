class ChangeColumnOnRequests < ActiveRecord::Migration
  def change
remove_column :requests, :response
add_column :requests, :response, :jsonb
  end
end
