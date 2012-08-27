class AddPubdateToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :pubdate, :string
  end
end
