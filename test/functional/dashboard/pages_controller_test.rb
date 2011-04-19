require 'test_helper'

class Dashboard::PagesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @admin    = Factory.create :admin, :email => 'root@site.com'
    @user     = Factory.create :user
    @section  = Factory.create :section
    @page     = Factory.create :page, :section => @section
  end

  test "factories should workd" do
    assert @admin
    assert @section
    assert @page
  end

  test "should get index as admin" do
    login_as @admin

    get :index, :section_id => @section.id
    assert_response :success
    assert_not_nil assigns(:pages)
  end

  test "should redirect if user is not admin" do
    login_as @user

    get :index, :section_id => @section.id
    assert_redirected_to new_user_session_path
  end

  test "should redirect to login if not logged in" do
    get :index, :section_id => @section.id
    assert_redirected_to new_user_session_path
  end

  test "should get new if admin" do
    login_as @admin

    get :new, :section_id => @section.id
    assert_response :success
  end

  test "should not get new if not admin" do
    login_as @user

    get :new, :section_id => @section.id
    assert_redirected_to new_user_session_path
  end

  test "should create page if admin" do
    login_as @admin

    assert_difference('Page.count') do
      post :create, :section_id => @section.id, :page => Factory.attributes_for(:page, :name => 'newest page', :section => @section)
    end

    assert_redirected_to dashboard_section_pages_path(@section)
  end


  test "shouldn't create page if not admin" do
    post :create, :section_id => @section.id, :page => Factory.attributes_for(:page, :name => 'newest page', :section => @section)
    assert_redirected_to new_user_session_path
  end

  test "should get edit if admin" do
    login_as @admin
    get :edit, :id => @page.id, :section_id => @section.id
    assert_response :success
  end

  test "should not get edit if not admin" do
    login_as @user
    get :edit, :id => @page.id, :section_id => @section.id
    assert_redirected_to new_user_session_path
  end

  test "should update page if admin" do
    login_as @admin

    put :update, :section_id => @section.id, :id => @page.id, :page => Factory.attributes_for(:page, :section => @section)
    assert_redirected_to dashboard_section_pages_path(@section)
  end

  test "shouldn't update page if not admin" do
    put :update, :section_id => @section.id, :id => @page.id, :page => Factory.attributes_for(:page, :section => @section)
    assert_redirected_to new_user_session_path
  end

  test "should destroy page if admin" do
    login_as @admin

    assert_difference('Page.count', -1) do
      delete :destroy, :section_id => @section.id, :id => @page.id
    end

    assert_redirected_to dashboard_section_pages_path(@section)
  end
end
