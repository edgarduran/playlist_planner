class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :song_name
      t.string :status
      t.string :song_id
      t.string :pl_id
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
