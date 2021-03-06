class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :show, :edit, :update, :following, :followers]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    if @user.admin?
      @addresses_count = Address.count
    else
      @addresses_count = @user.addresses.count
    end
  end

  def new
    if current_user.nil?
      @user = User.new
    else
      flash[:notice] = "You already have an acoount"
      redirect_to(root_path)
    end
  end
  
  def create
    if current_user.nil?
      @user = User.new(params[:user])
      if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App!"
        redirect_to User.last #this is a hack User.last should be @user but that one always have id 0
      else
        render 'new'
      end
    else
      flash[:notice] = "You already have an acoount"
      redirect_to(root_path)
    end
  end
  
  def edit
  end
  
  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def destroy
    user = User.find(params[:id])
    if current_user == user
      flash[:notice] = "You cannot delete your self"
    else
      user.destroy
      flash[:success] = "User destroyed."
    end
    redirect_to users_path
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
