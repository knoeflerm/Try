class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.string :name
      t.string :surname
      t.string :street
      t.integer :streetnumber
      t.integer :zipcode
      t.string :town
      t.string :link

      t.timestamps
    end
    add_index :addresses, [:user_id, :created_at]
  end
end
