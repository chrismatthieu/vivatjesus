class AddWifenameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :wifename, :string
  end
end
