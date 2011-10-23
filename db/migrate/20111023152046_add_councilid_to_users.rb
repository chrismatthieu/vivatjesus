class AddCouncilidToUsers < ActiveRecord::Migration
  def change
    add_column :users, :council_id, :integer
  end
end
