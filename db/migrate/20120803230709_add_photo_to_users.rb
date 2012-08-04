class AddPhotoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :photo, :string
    add_column :users, :allowemail, :boolean
    add_column :users, :website, :string
    add_column :users, :bio, :text
  end
end
