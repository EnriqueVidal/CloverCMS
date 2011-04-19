require 'test_helper'

class Dashboard::SectionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @admin    = Factory.create :admin
    @user     = Factory.create :user, :email => 'some@dude.com'
    @section  = Factory.create :section
  end

  test "factories should pass" do
    assert @admin
    assert @section
  end

  test "should get index if admin" do
    login_as @admin

    get :index, :page => 1
    assert_response :success
    assert_not_nil assigns(:sections)
  end

  test "should not get index if not admin" do
    login_as @user

    get :index, :page => 1
    assert_redirected_to new_user_session_path
  end

  test "should not get index if not logged in" do
    get :index, :page => 1
    assert_redirected_to new_user_session_path
  end

  test "should get new if admin" do
    login_as @admin
    get :new
    assert_response :success
  end

  test "should not get new if not admin" do
    login_as @user
    get :new
    assert_redirected_to new_user_session_path
  end

  test "should not get new if not logged in" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "should create section if not admin" do
    login_as @admin
    assert_difference('Section.count') do
      post :create, :section => Factory.attributes_for(:section, :name => 'New section')
    end

    assert_redirected_to dashboard_sections_path
  end

  test "should get edit if admin" do
    login_as @admin
    get :edit, :id => @section.id
    assert_response :success
  end

  test "should get edit if not admin" do
    login_as @user
    get :edit, :id => @section.id
    assert_redirected_to new_user_session_path
  end

  test "should get edit if not logged in" do
    get :edit, :id => @section.id
    assert_redirected_to new_user_session_path
  end

  test "should update section if admin" do
    login_as @admin
    put :update, :id => @section.id, :section => Factory.attributes_for(:section)
    assert_redirected_to dashboard_sections_path
  end

  test "should destroy section if admin" do
    login_as @admin
    assert_difference('Section.count', -1) do
      delete :destroy, :id => @section.to_param
    end

    assert_redirected_to dashboard_sections_path
  end
end
