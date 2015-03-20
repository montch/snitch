class NoJsonbOnRequests < ActiveRecord::Migration
  def change
remove_column :requests, :response
add_column :requests, :response, :json
  end
end
