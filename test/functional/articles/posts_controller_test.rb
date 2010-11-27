require 'test_helper'
require 'will_paginate'

class Articles::PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @admin  = Factory :admin
    @user   = Factory :user, :email => 'some@dude.com'
    @post   = Factory 'Articles::Post', :user_id => @user.id
    Articles::Post.any_instance.stubs(:paginate).with(:page => 1, :per_page => 5).returns([].paginate)
  end
  
  test "factories should pass" do
    assert @admin
    assert @user
    assert @post
  end

  test "should get to index if admin" do
    become @admin
    
    get :index, :page => 1
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should not get to index if user with rights" do
    become @user
    @controller.stubs(:check_authorization).returns(true)
    
    get :index, :page => 1
    assert_response :success
  end
  
  test "should not get to index if not logged in" do
    get :index, :page => 1
    assert_redirected_to new_user_session_path
  end

  test "should get new if admin" do
    become @admin
    get :new
    assert_response :success
  end

  test "should not get new if user with rights" do
    become @user
    @controller.stubs(:check_authorization).returns(true)
    
    get :new
    assert_response :success
  end

  test "should not get new if user has no rights" do
    become @user
    get :new
    assert_redirected_to new_user_session_path
  end
  
  test "should not get new if not logged in" do
    get :new
    assert_redirected_to new_user_session_path
  end
  
  test "should create post if admin" do
    become @admin
    assert_difference('Articles::Post.count') do
      post :create, :articles_post => Factory.attributes_for('Articles::Post', :name => 'Newest post')
    end

    assert_redirected_to articles_posts_path
  end

  test "should get edit if admin" do
    become @admin
    get :edit, :id => @post.id
    assert_response :success
    assigns :posts
  end

  test "should get edit if user has authorization and post belongs to user" do
    @controller.stubs(:check_authorization).returns(true)
    become @user
    get :edit, :id => @post.id
    
    assert_response :success
  end

  test "should get edit if user has no authorization" do
    become @user
    get :edit, :id => @post.id
    
    assert_redirected_to new_user_session_path
  end
  
  test "should update section if admin" do
    become @admin
    put :update, :id => @post.id, :articles_post => Factory.attributes_for('Articles::Post')
    assert_redirected_to articles_posts_path
  end

  test "should update section if user has authorization and post belongs to user" do
    @controller.stubs(:check_authorization).returns(true)
    become @user
    put :update, :id => @post.id, :articles_post => Factory.attributes_for('Articles::Post')
    assert_redirected_to articles_posts_path
  end
  
  test "should destroy section if admin" do
    become @admin
    assert_difference('Articles::Post.count', -1) do
      delete :destroy, :id => @post.id
    end

    assert_redirected_to articles_posts_path
  end

  private

  def become user=nil
    @controller.stubs(:current_user).returns(user)
  end
end