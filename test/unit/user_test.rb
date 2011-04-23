require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "test email validations" do
    user = Factory.build :user, :email => ''
    assert user.invalid?

    %w/invalid_email in@va@lid invalit@..@/.each do |invalid_email|
      user.email = invalid_email
      assert user.invalid?
    end
  end

  test "test username validations" do
    user = Factory.build :user, :username => ''
    assert user.invalid?

    %w/&*)@user tes!@@k AScñé/.each do |invalid_username|
      user.username = invalid_username
      assert user.invalid?
    end
  end
end
