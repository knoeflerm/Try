class AddPhoneNumberToAddress < ActiveRecord::Migration
  def change
    add_column :addresses, :phone, :string, limit: 12
    add_column :addresses, :mobile, :string, limit: 12
  end
end
