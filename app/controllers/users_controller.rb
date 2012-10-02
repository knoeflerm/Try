class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to User.last #this is a hack User.last should be @user but that one always have id 0
    else
      render 'new'
    end
  end
  
end
