require 'test_helper'

class Dashboard::ArticlesControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @admin    = Factory :admin
    @user     = Factory :user,    :email => 'some@dude.com'
    @article  = Factory :article, :user_id => @user.id
  end

  test "factories should pass" do
    assert @admin
    assert @user
    assert @article
  end

  test "should get to index if admin" do
    login_as @admin

    get :index, :page => 1
    assert_response :success
    assert_not_nil assigns(:articles)
  end

  test "should not get to index if user with rights" do
    login_as @user
    @controller.stubs(:check_authorization).returns(true)

    get :index, :page => 1
    assert_response :success
  end

  test "should not get to index if not logged in" do
    get :index, :page => 1
    assert_redirected_to new_user_session_path
  end

  test "should get new if admin" do
    login_as @admin
    get :new
    assert_response :success
  end

  test "should not get new if user with rights" do
    login_as @user
    @controller.stubs(:check_authorization).returns(true)

    get :new
    assert_response :success
  end

  test "should not get new if user has no rights" do
    login_as @user
    get :new
    assert_redirected_to new_user_session_path
  end

  test "should not get new if not logged in" do
    get :new
    assert_redirected_to new_user_session_path
  end

  test "should create article if admin" do
    login_as @admin
    assert_difference('Article.count') do
      post :create, :article => Factory.attributes_for(:article, :name => 'Newest article')
    end

    assert_redirected_to dashboard_articles_path
  end

  test "should get edit if admin" do
    login_as @admin
    get :edit, :id => @article.id
    assert_response :success
    assigns :articles
  end

  test "should get edit if user has authorization and article belongs to user" do
    @controller.stubs(:check_authorization).returns(true)
    login_as @user
    get :edit, :id => @article.id

    assert_response :success
  end

  test "should get edit if user has no authorization" do
    login_as @user
    get :edit, :id => @article.id

    assert_redirected_to new_user_session_path
  end

  test "should update section if admin" do
    login_as @admin
    put :update, :id => @article.id, :article => Factory.attributes_for(:article)
    assert_redirected_to dashboard_articles_path
  end

  test "should update section if user has authorization and article belongs to user" do
    @controller.stubs(:check_authorization).returns(true)
    login_as @user
    put :update, :id => @article.id, :article => Factory.attributes_for(:article)
    assert_redirected_to dashboard_articles_path
  end

  test "should destroy article if admin" do
    login_as @admin
    assert_difference('Article.count', -1) do
      delete :destroy, :id => @article.id
    end

    assert_redirected_to dashboard_articles_path
  end
end
