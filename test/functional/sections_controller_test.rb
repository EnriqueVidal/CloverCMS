require 'test_helper'
require File.join(File.dirname(__FILE__), '..', 'factories')
require 'will_paginate'

class SectionsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @admin    = Factory(:admin)
    @user     = Factory(:user, :email => 'some@dude.com')
    @section  = Factory(:section)
  end
  
  test "factories should pass" do
    assert @admin
    assert @section
  end
  
  test "should get index if admin" do
    become :admin
    Section.expects(:paginate).with(:page => 1, :per_page => 5).returns([].paginate)
    
    get :index, :page => 1
    assert_response :success
    assert_not_nil assigns(:sections)
  end

  test "should not get index if not admin" do
    become :user
    
    get :index, :page => 1
    assert_redirected_to new_user_session_path
  end

  test "should not get index if not logged in" do    
    get :index, :page => 1
    assert_redirected_to new_user_session_path
  end

  test "should get new if admin" do
    become :admin
    get :new
    assert_response :success
  end

  test "should not get new if not admin" do
    become :user
    get :new
    assert_redirected_to new_user_session_path
  end
  
  test "should not get new if not logged in" do
    get :new
    assert_redirected_to new_user_session_path
  end
  
  test "should create section if not admin" do
    become :admin
    assert_difference('Section.count') do
      post :create, :section => Factory.attributes_for(:section, :name => 'New section')
    end

    assert_redirected_to sections_path
  end
  
  test "should get edit if admin" do
    become :admin
    get :edit, :id => @section.id
    assert_response :success
  end
  
  test "should get edit if not admin" do
    become :user
    get :edit, :id => @section.id
    assert_redirected_to new_user_session_path
  end
  
  test "should get edit if not logged in" do
    get :edit, :id => @section.id
    assert_redirected_to new_user_session_path
  end
  
  test "should update section if admin" do
    become :admin
    put :update, :id => @section.id, :section => Factory.attributes_for(:section)
    assert_redirected_to sections_path
  end
  
  test "should destroy section if admin" do
    become :admin
    assert_difference('Section.count', -1) do
      delete :destroy, :id => @section.to_param
    end

    assert_redirected_to sections_path
  end
  
  def become type=nil
    case type
    when :admin then 
      SectionsController.any_instance.stubs(:current_user).returns(@admin)
    when :user  then 
      SectionsController.any_instance.stubs(:current_user).returns(@user)
    end
  end
end
