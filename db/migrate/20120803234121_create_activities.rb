class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.integer :user_id
      t.integer :status_id
      t.integer :follow_id
      t.integer :register_id
      t.string :message

      t.timestamps
    end
  end
end
