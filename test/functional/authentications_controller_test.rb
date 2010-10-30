require 'test_helper'

class AuthenticationsControllerTest < ActionController::TestCase
  include Devise::TestHelpers
    
  setup do
    @auth_fb      = { 'provider' => 'facebook',   'uid' => 'facebook_uid',  'user_info' => { 'nickname' => 'fb_user' }, 'extra' => { 'user_hash' => { 'email' => 'test@test.com' } } }
    @auth_tw      = { 'provider' => 'twitter',    'uid' => 'twitter_uid',   'user_info' => { 'nickname' => 'tw_user'} }
    @auth_openid  = { 'provider' => 'open_id',    'uid' => 'open_id_uid',   'user_info' => { 'email' => 'user@gmail.com' } }
    @user           = Factory(:user, :email => 'test@test.com', :username => 'test')
    @authentication = Factory(:authentication, :user_id => @user.id)
  end

  test 'factories' do
    assert @user.present?
    assert @authentication.present?
  end

  test "should not get index if not logged in" do
    get :index
    assert_redirected_to new_user_session_path
  end
  
  test "should get to index if logged in" do
    become @user
    
    get :index
    assert_response :success
  end

  test "should create authentication with open_id" do
    @controller.request.env['omniauth.auth'] = @auth_openid
    
    assert_difference('Authentication.count') do
      post :create
    end
    @authentication = Authentication.last
    assert @authentication.valid?
    assert @authentication.user.valid?
    assert_redirected_to '/'
  end
  
  test "sould create authentication with facebook" do
    @controller.request.env['omniauth.auth'] = @auth_fb
    
    assert_difference('Authentication.count') do
      post :create
    end
    @authentication = Authentication.last
    assert @authentication.valid?
    assert @authentication.user.valid?
    assert_redirected_to '/'
  end
  
  test "should redirect to registrations when creating with twitter" do
    @controller.request.env['omniauth.auth'] = @auth_tw
    post :create
    
    assert_redirected_to new_user_registration_path
  end

  test "should destroy authentication if logged in" do
    become @user
    
    assert_difference('Authentication.count', -1) do
      delete :destroy, :id => @authentication.id
    end

    assert_redirected_to authentications_path
  end

  test "should not destroy if not logged in" do
    delete :destroy, :id => 1
    assert_redirected_to new_user_session_path
  end
  
  test "should not destroy if authentication does not belong to user" do
    become @user
    
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, :id => 99999
    end
  end

  private
  
  def become user
    AuthenticationsController.any_instance.stubs(:authenticate_user!).returns(true)
    AuthenticationsController.any_instance.stubs(:current_user).returns(user)
  end
end