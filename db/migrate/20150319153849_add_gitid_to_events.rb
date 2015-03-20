class AddGitidToEvents < ActiveRecord::Migration
  def change
    add_column :events, :git_id, :string
  end
end
