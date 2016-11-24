class SessionsController < ApplicationController
  def new
  end

  def destroy
    log_out if logged_in? # or session[:user_id]
      
    redirect_to root_url
  end

  def create
  	# render html: params.inspect
  	@user = User.find_by(email: params[:session][:email].downcase)

  	if @user && @user.authenticate(params[:session][:password])
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
  		redirect_back_or @user
  	else
  		flash.now[:danger] = 'Invalid email/password combination' 
  		render 'new'
  	end
  end
end
