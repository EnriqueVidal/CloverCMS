ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'mocha'

class ActiveSupport::TestCase
  def login_as user
    @controller.class.any_instance.stubs(:current_user).returns(user)
  end
end
