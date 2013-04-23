class AlterAddressLinkToText < ActiveRecord::Migration
  def self.up
    change_table :addresses do |t|
      t.change :link, :text
    end
  end
  def self.down
    change_table :addresses do |t|
      t.change :link, :string
    end
  end
end
