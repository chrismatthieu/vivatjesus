class AddMobileToCouncil < ActiveRecord::Migration
  def change
    add_column :councils, :mobileurl, :string
  end
end
