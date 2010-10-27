require 'test_helper'
require File.join(File.dirname(__FILE__), '..', 'factories')

class AuthenticationTest < ActiveSupport::TestCase
  def setup
    @auth_fb = { 'provider' => 'facebook',  'uid' => 'facebook_uid',  'user_info' => { 'nickname' => 'fb_user'}, 'extra' => { 'user_hash' => { 'email' => 'test@test.com' } } }
    @auth_tw = { 'provider' => 'twitter',   'uid' => 'twitter_uid',   'user_info' => { 'nickname' => 'tw_user'} }
  end
  
  # Replace this with your real tests.
  test "Authentication should always belong to an user" do
    
  end
end
