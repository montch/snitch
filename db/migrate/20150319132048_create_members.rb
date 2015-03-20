class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.integer :team_id
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :github_login
      t.boolean :deactivated

      t.timestamps
    end
  end
end
