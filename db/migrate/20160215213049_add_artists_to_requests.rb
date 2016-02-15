class AddArtistsToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :artists, :string
  end
end
