require 'test_helper'

class AuthenticationTest < ActiveSupport::TestCase
  def setup
    @auth_fb = { 'provider' => 'facebook',  'uid' => 'facebook_uid',  'user_info' => { 'nickname' => 'fb_user'}, 'extra' => { 'user_hash' => { 'email' => 'test@test.com' } } }
    @auth_tw = { 'provider' => 'twitter',   'uid' => 'twitter_uid',   'user_info' => { 'nickname' => 'tw_user'} }
  end

  test "Authentication should contain provider and uid" do
    @authentication = Authentication.new
    assert !@authentication.valid?
    @authentication.provider  = @auth_tw['provider']
    assert !@authentication.valid?    
    @authentication.uid       =  @auth_tw['uid']
    assert @authentication.valid?
  end

  test "Authentication should work when there is an user" do
    @user = User.new
    @authentication = @user.apply_omniauth(@auth_fb, @auth_fb['extra']['user_hash']['email'])
    assert @user.save!
    assert @user.valid?
    assert @authentication.valid?
  end
  
  test "Authentications without email can't create a user" do
    @user = User.new
    @user.apply_omniauth(@auth_tw)
    assert_raise ActiveRecord::RecordInvalid do
      @user.save!
    end
    
    @user.email = 'tw_user@email.com'
    assert @user.valid?
    assert @user.save
  end
end
