class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :council_id
      t.string :title
      t.text :description
      t.text :paypalcode
      t.boolean :promoactive

      t.timestamps
    end
  end
end
