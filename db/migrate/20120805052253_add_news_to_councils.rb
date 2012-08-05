class AddNewsToCouncils < ActiveRecord::Migration
  def change
    add_column :councils, :newsurl, :string
  end
end
