class ChangeLocationInEvents < ActiveRecord::Migration
  def change
    rename_column :events, :location, :eventlocation
  end
end
