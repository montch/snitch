class AddStiffToMembers < ActiveRecord::Migration
  def change
    add_column :members, :avatar_url, :string
    add_column :members, :github_id, :string
  end
end
