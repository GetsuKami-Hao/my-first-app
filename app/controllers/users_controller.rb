class UsersController < ApplicationController

  before_action :logged_in_user , only: [:edit, :update, :index, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new(new_user_params)

  	if @user.save
      log_in @user  #sign up after login
  		flash[:success] = "Welcome to the Sample App!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
  end

  def update
    if @user.update_attributes(edit_user_params)
      flash[:success] = "Update successfully."
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end

  private
  	def new_user_params
  		params.require(:user).permit(:name,:email,:password,:password_confirmation)
 	 end

   def edit_user_params
      params.require(:user).permit(:name,:password,:password_confirmation)
   end

   def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."   
      redirect_to login_url
    end
   end

   def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
