class ChangeAliasToMembers < ActiveRecord::Migration
  def change
 change_column :members, :alias_list, :string

  end
end
