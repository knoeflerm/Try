class ContactsController < ApplicationController
  def show
    #FIXME: Why does User.where(:admin => true) not work?
    user = User.find(:first, :conditions => ["admin = ?", true])
    @contact = Address.find(:first, :conditions => ["user_id = ?", user])
  end
end
