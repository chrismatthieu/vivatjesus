class AddStateurlToCouncils < ActiveRecord::Migration
  def change
    add_column :councils, :stateurl, :string
  end
end
