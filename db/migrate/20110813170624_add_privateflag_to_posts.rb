class AddPrivateflagToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :privateflag, :boolean
  end
end
