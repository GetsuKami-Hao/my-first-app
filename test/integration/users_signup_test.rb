require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

	def setup
    ActionMailer::Base.deliveries.clear 
  end

	test "invalid signup information" do 
		get signup_path
		assert_no_difference 'User.count' do  #User.count return  database's user count. 
		post users_path, params: { user: { name: "",
																	email: "user@invalid" , 
																	password: "f" ,
																	password_confirmation: "asd" } }

			#send a post request.
		end

		assert_template 'users/new'
	end
 
	test "valid signup information" do # with account activation
		get signup_path
		assert_difference 'User.count', 1 do
		post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
		end

		follow_redirect!
		assert_not_nil flash.nil?
		
	# 	assert_equal 1, ActionMailer::Base.deliveries.size
	# 	#eliveries 是一个数组，用于统计所有发出的邮件
 #    #所以我们要在 setup 方法中把它清空，以防其他测试发送了邮件
    
	# 	user = assigns(:user)
	# 	assert_not user.activated?
	# 	#　激活前尝试登陆
	# 	log_in_as(user)
	# 	assert_not is_logged_in?
    
 #    # 令牌无效
 #    get edit_account_activation_path("invalid token", email: user.email)
 #    assert_not is_logged_in?

 #    #令牌有效。电子邮件地址不对
 #    get edit_account_activation_path(user.activation_token, email: "wrong")
 #    assert_not is_logged_in?

 #    #成功激活
 #    get edit_account_activation_path(user.activation_token, email: user.email)
 #    assert user.reload.activated?

 #    follow_redirect!
	# 	# assert_template 'users/show'
	# 	# assert is_logged_in?
	# 	assert_template 'users/show'
	# 	assert is_logged_in?
	# 	# assert_not_nil flash.nil?
	end
end
