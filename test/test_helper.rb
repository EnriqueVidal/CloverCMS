ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha'

class ActiveSupport::TestCase
end

class ActionController::TestCase
  def login_as(user, role=nil)
    @controller.class.any_instance.stubs(:current_user).returns(user)
    @controller.class.any_instance.expects(:authenticate_user!).returns(true)

    user.has_role! role if role.present?
  end
end
