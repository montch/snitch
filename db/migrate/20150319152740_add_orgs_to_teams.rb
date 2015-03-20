class AddOrgsToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :org_id, :integer
  end
end
