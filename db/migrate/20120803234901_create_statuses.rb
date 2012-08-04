class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.integer :user_id
      t.string :message
      t.string :mylat
      t.string :mylong
      t.string :location

      t.timestamps
    end
  end
end
