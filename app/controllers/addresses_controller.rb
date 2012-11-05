class AddressesController < ApplicationController
  def index
    @addresses = Address.paginate(page: params[:page])
  end
  
  def new
  end
end
