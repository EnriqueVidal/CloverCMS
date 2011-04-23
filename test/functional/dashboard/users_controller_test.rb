require 'test_helper'

class Dashboard::UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @user   = Factory.create :user, :email => 'some@dude.com', :confirmed_at => Time.now
  end

  test "if not admin can not get index" do
    get :index
    assert_redirected_to new_user_session_path
  end

  test "if not admin and not right can not get index" do
    login_as @user
    get :index
    assert_redirected_to new_user_session_path
  end

  test "if admin can get index" do
    login_as @user, :admin
    get :index
    assert_response :success
    assert_template :index
  end

  test "admin can delete users" do
    login_as @user, :admin

    assert_difference "User.count", -1 do
      delete :destroy, :id => @user.id
      assert assigns(:user)
      assert_redirected_to dashboard_users_path
    end
  end
end
