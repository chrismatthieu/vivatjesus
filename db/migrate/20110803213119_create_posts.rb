class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :postname
      t.text :postbody

      t.timestamps
    end
  end
end
