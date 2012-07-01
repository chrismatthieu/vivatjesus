class AddCouncilIdToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :council_id, :integer
  end
end
