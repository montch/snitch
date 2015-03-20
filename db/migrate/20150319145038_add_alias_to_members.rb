class AddAliasToMembers < ActiveRecord::Migration
  def change
    add_column :members, :alias_list, :json
  end
end
