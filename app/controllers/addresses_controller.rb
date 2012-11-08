class AddressesController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user,     only: :index
  
  def index
    @addresses = Address.paginate(page: params[:page])
    @title = "All addresses"
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
  
  def new
  end
end
