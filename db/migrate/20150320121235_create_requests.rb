class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :request
      t.text :response

      t.timestamps
    end
  end
end
