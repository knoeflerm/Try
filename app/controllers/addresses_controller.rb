class AddressesController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,     only: :index
  
  def index
    @addresses = Address.paginate(page: params[:page])
    @title = "All addresses"
  end
  
  def show
  end
  
  def edit
    @address = Address.find(params[:id])
  end
  
  def show
    user = User.find(params[:id])
    if user.admin?
      @title = "All addresses"
      @addresses = Address.paginate(page: params[:page])
    else
      @title = "Your addresses"
      @addresses = user.addresses.paginate(page: params[:page])
    end
    render 'index'
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
end
