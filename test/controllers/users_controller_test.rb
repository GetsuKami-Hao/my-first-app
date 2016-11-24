require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:little)
		@other = users(:other)
	end

  test "should redirect destroy when logged in as a non-admin" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect delete when current user is not admin" do
    log_in_as(@other)

    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "admin should not be modified by patch" do
    log_in_as(@user)
    admin = @user.admin
    patch user_path(@user), params: { user: { admin: !@user.admin }}
    assert_equal admin, @user.reload.admin
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other)
    assert_not @other.admin?
    patch user_path(@other), params: {
                                    user: { password:              '',
                                            password_confirmation: '',
                                            admin: true } }
    assert_not @other.reload.admin                                            
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect edit when not logged in" do
  	get edit_user_path(@user)
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
  	patch user_path(@user) , params: { user: { name: @user.name}}
  	assert_not flash.empty?
  	assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
  	log_in_as(@user)
  	get edit_user_path(@other)
  	assert flash.empty?
  	assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
  	log_in_as(@user)
  	patch user_path(@other), params: { user: { name: @user.name}}
  	assert flash.empty?
  	assert_redirected_to root_url
  end

end
