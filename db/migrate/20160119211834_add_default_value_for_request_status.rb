class AddDefaultValueForRequestStatus < ActiveRecord::Migration
  def change
    change_column_default(:requests, :status, 'pending')
  end
end
