class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fbid, :string
    add_column :users, :fbtoken, :string
    add_column :users, :uid, :string
    add_column :users, :provider, :string
    add_column :users, :access_token, :string
    add_column :users, :access_secret, :string
  end
end
