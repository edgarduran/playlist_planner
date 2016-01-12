class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :user_name
      t.string :email
      t.string :token
      t.string :refresh_token
      t.string :image
      t.string :display_name

      t.timestamps null: false
    end
  end
end
