class AddressesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:edit, :update, :destroy] 
  before_filter :admin_user,     only: :index
  
  def index
    @addresses = Address.paginate(page: params[:page])
    @title = "addresses"
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def update
    if @address.update_attributes(params[:address])
      flash[:success] = "Address updated"
      redirect_to address_path(current_user)
    else
      render 'edit'
    end
  end
  
  def show
    begin
      user = User.find(params[:id])
      currentuser = current_user
      if currentuser.admin? && currentuser == user
        @title = "All addresses"
        @addresses = Address.paginate(page: params[:page])
      elsif !currentuser.admin? && currentuser == user
        if user.addresses.count > 1
          @title = user.name << "'s " << pluralize("address") 
        else
          @title = user.name << "'s address"
        end      
        @addresses = user.addresses.paginate(page: params[:page])  
      else
        redirect_to(root_path)
        return      
      end
      render 'index'
    rescue ActiveRecord::RecordNotFound => e
      flash[:error] = "Could not find that user to display its addresses"
      redirect_to(root_path)
    end
  end
  
  def destroy
    address = Address.find(params[:id])
    if address.user_id == current_user.id || current_user.admin?
      address.destroy
      flash[:success] = "Address destroyed"
      redirect_to address_path(current_user)
    else
      flash[:error] = "Prohibited to delete this address"
      redirect_to(root_path)
    end
  end
  
  def new
    @address = Address.new
  end
  
  def create
    @address = Address.new(params[:address])
    @address.user = current_user
    if @address.save
      flash[:success] = "Address saved"
      redirect_to address_path(current_user)
    else
      render 'new'
    end    
  end
  
  private
  
  def correct_user
    begin
      @address = Address.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      @address = nil
    end
    redirect_to(root_path) unless !@address.nil? && @address.user_id == current_user.id || current_user.admin?
  end
  
  def pluralize(word)
    ActiveSupport::Inflector.pluralize(word)
  end
end
