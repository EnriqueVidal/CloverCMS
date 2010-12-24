require 'test_helper'
require 'will_paginate'

class ArticlesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @admin    = Factory :admin
    @user     = Factory :user,    :email => 'some@dude.com'
    @article  = Factory :article, :user_id => @user.id
    Article.any_instance.stubs(:paginate).with(:page => 1, :per_page => 5).returns([].paginate)
  end
  
  test "factories should pass" do
    assert @admin
    assert @user
    assert @article
  end

  test "should get to index if admin" do
    become @admin
    
    get :index, :page => 1
    assert_response :success
    assert_not_nil assigns(:articles)
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
  
  test "should create article if admin" do
    become @admin
    assert_difference('Article.count') do
      post :create, :article => Factory.attributes_for(:article, :name => 'Newest article')
    end

    assert_redirected_to articles_path
  end

  test "should get edit if admin" do
    become @admin
    get :edit, :id => @article.id
    assert_response :success
    assigns :articles
  end

  test "should get edit if user has authorization and article belongs to user" do
    @controller.stubs(:check_authorization).returns(true)
    become @user
    get :edit, :id => @article.id

    assert_response :success
  end

  test "should get edit if user has no authorization" do
    become @user
    get :edit, :id => @article.id

    assert_redirected_to new_user_session_path
  end
  
  test "should update section if admin" do
    become @admin
    put :update, :id => @article.id, :article => Factory.attributes_for(:article)
    assert_redirected_to articles_path
  end

  test "should update section if user has authorization and article belongs to user" do
    @controller.stubs(:check_authorization).returns(true)
    become @user
    put :update, :id => @article.id, :article => Factory.attributes_for(:article)
    assert_redirected_to articles_path
  end
  
  test "should destroy article if admin" do
    become @admin
    assert_difference('Article.count', -1) do
      delete :destroy, :id => @article.id
    end

    assert_redirected_to articles_path
  end

  private

  def become user=nil
    @controller.stubs(:current_user).returns(user)
  end
end