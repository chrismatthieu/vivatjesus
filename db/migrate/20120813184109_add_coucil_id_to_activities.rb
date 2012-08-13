class AddCoucilIdToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :council_id, :integer
  end
end
