class AddProfileToUsers < ActiveRecord::Migration
  def change
    add_column :users, :degree, :integer
    add_column :users, :twitter, :string
    add_column :users, :facebook, :string
    add_column :users, :googleplus, :string
    add_column :users, :member, :boolean
    add_column :users, :officer, :boolean
    add_column :users, :officertitle, :string
  end
end
