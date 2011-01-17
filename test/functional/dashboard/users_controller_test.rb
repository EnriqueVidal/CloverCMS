require 'test_helper'
require 'will_paginate'

class Dashboard::UsersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  def setup
    @admin  = Factory :admin, :confirmed_at => Time.now
    @user   = Factory :user, :email => 'some@dude.com', :confirmed_at => Time.now
    Factory :role
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
    login_as @admin
    get :index
    assert_response :success
    assert_template :index
  end

  test "admin can get edit" do
    login_as @admin

    get :edit, :id => @admin.id
    assert_response :success
    assert_template :edit
  end

  test "admin can update users roles" do
    login_as @admin

    assert_difference "User.find(#{@user.id}).roles.count" do
      put :update, :roles => { 1 => Authorization::Role.first.id }, :id => @user.id
      assert assigns(:user)
      assert_redirected_to edit_dashboard_user_path(@user)
    end
  end

  test "admin can delete users" do
    login_as @admin

    assert_difference "User.count", -1 do
      delete :destroy, :id => @user.id
      assert assigns(:user)
      assert_redirected_to dashboard_users_path
    end
  end
end
