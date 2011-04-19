require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  def setup
    @theme = Factory.create :setting, :name => 'theme', :value => 'clover', :destroyable => false
  end

  test "setting should have a name and value" do
    setting = Setting.new
    assert setting.invalid?

    setting.name = 'key'
    assert setting.invalid?

    setting.value = 'value'
    assert setting.valid?
  end

  test "setting name should be unique" do
    setting = Setting.new :name => 'theme', :value => 'clover'
    assert setting.invalid?

    setting.name = 'new_setting'
    assert setting.valid?
  end

  test "settings count increase after creating a new setting" do
    assert_difference 'Setting.count' do
      Factory.create(:setting)
    end
  end

  test "settings name should be properly formatted" do
    setting = Factory.build(:setting, :name => 'badly formated name ')
    assert setting.invalid?
  end

  test "should not delete setting if setting is not destroyable" do
    setting = Factory.create(:setting, :destroyable => true)

    assert !@theme.delete
    assert setting.delete
  end
end
