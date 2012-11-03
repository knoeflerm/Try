class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :name
      t.string :surname
      t.string :street
      t.integer :streetnumber
      t.integer :zipcode
      t.string :link

      t.timestamps
    end
  end
end
