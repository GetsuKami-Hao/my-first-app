module SessionsHelper

# 重定向到存储的地址或者默认地址
	def redirect_back_or(default)
		redirect_to(session[:forwarding_url] || default)
		session.delete(:forwarding_url)
	end

# 存储后面需要使用的地址,只存储get请求的.
	def store_location
		session[:forwarding_url] = request.original_url if request.get?
	end

# log in user
	def log_in(user)
		session[:user_id] = user.id
	end

#return user in session(now)(unless without)
	def current_user
		if(user_id = session[:user_id]) # have user log in
			@current_user ||= User.find_by(id: user_id)
		elsif (user_id = cookies.signed[:user_id])
			
			user = User.find_by(id: user_id)
			if user && user.authenticated?(cookies[:remember_token])
				log_in user
				@current_user = user
			end
		end
	end	

# if user log in ,return true, else return false
	def logged_in?
 		!current_user.nil?
	end

# exit user
	def log_out
		session.delete(:user_id)
		@current_user = nil
	end

#remember user in session
	def remember(user)
		user.remember
		cookies.permanent.signed[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end

	def forget(user)
		user.forget # user.rb method # reset user table remember_digest nil
		cookies.delete(:user_id)
		cookies.delete(:remember_token)
	end

	def log_out
		forget(current_user)
		session.delete(:user_id) #delete session
		@current_user = nil
	end

	def current_user?(user)
		user == current_user
	end

end
