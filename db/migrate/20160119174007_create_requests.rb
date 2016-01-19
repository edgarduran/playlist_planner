class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :name
      t.string :status
      t.string :song_info
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
