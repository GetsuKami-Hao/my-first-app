require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_path
    assert_response :success
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title" , "Home | #{@base_title}"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title" , "Help | #{get_title}" #call method
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title" , "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title" , "Contact | #{@base_title}"
  end

  def setup   # method name must is setup
    @base_title = "GetsuKami"
  end

  def get_title  
    @base_title = "GetsuKami"
  end

end
