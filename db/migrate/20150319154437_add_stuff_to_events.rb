class AddStuffToEvents < ActiveRecord::Migration
  def change
    add_column :events, :git_type, :string
    add_column :events, :git_actor, :string
    add_column :events, :git_actor_id, :string
    add_column :events, :git_repo, :string
    add_column :events, :git_repo_id, :string
    add_column :events, :comment, :string
    add_column :events, :payload, :json
  end
end
