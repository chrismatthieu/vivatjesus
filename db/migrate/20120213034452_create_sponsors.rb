class CreateSponsors < ActiveRecord::Migration
  def change
    create_table :sponsors do |t|
      t.string :sponsorname
      t.string :url
      t.text :description

      t.timestamps
    end
  end
end
