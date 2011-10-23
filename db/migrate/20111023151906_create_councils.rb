class CreateCouncils < ActiveRecord::Migration
  def change
    create_table :councils do |t|
      t.string :councilname
      t.string :councilnumber
      t.string :twitterurl
      t.string :facebookurl
      t.string :linkedinurl
      t.string :googleplusurl
      t.string :email
      t.string :posterousurl
      t.string :calendarurl
      t.text :about

      t.timestamps
    end
  end
end
