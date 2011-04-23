require 'test_helper'

class Dashboard::SettingsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user     = Factory.create :user
    @setting  = Factory.create :setting, :name => "test_setting", :value => "true", :description => "this setting is just for testing"
    @setting.destroyable = false
    @setting.save!
  end

  test "should not get to any action if not authorized" do
    actions = %w/index new edit/
    actions.each do |action|
      get action, :id => 1
      assert_redirected_to new_user_session_path
    end
  end

  test "should not be able to post to any action if not authorized" do
    post :create, :setting => {}
    assert_redirected_to new_user_session_path
  end

  test "should not be able to put to any action if not authorized" do
    put :update, :id => 1, :setting => {}
    assert_redirected_to new_user_session_path
  end

  test "should not be able to delete if not authorized" do
    delete :destroy, :id => 1
    assert_redirected_to new_user_session_path
  end

  test "should not be able to update non destroyable settings name" do
    login_as @user

    new_name = "new_name"
    put :update, :id => @setting.id, :setting => { :name => new_name }
    assert assigns(:setting)
    assert_redirected_to dashboard_settings_path
    assert_not_equal new_name, @setting.name
  end

  test "should be able to update value and description from all settings" do
    login_as @user

    new_values      = { :value => "false", :description => "this is can be changed" }
    original_values = @setting.attributes
    put :update, :id => @setting.id, :setting => new_values
    assert assigns(:setting)
    assert_redirected_to dashboard_settings_path
    assert_not_equal original_values[:value], @setting.value
    assert_not_equal original_values[:description], @setting.description
  end

  test "authorized users should be able to create new settings" do
    login_as @user

    new_setting_values = Factory.attributes_for :setting

    assert_difference 'Setting.count' do
      post :create, :setting => new_setting_values
      assert assigns(:setting)
      assert_redirected_to dashboard_settings_path
      assert assigns(:setting).destroyable
    end
  end

  test "authorized users should be able to destroy destroyable settings" do
    login_as @user

    Factory.create :setting

    assert_difference 'Setting.count', -1 do
      delete :destroy, :id => Setting.last.id
      assert assigns(:setting)
      assert_redirected_to dashboard_settings_path
    end
  end

  test "should not be able to destroy destroyable settings" do
    login_as @user

    assert_no_difference 'Setting.count' do
      delete :destroy, :id => @setting.id
      assert assigns(:setting)
      assert_redirected_to dashboard_settings_path
    end
  end
end
