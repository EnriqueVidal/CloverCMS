require 'test_helper'

class Authorization::RightTest < ActiveSupport::TestCase
  test "Controller and Action must be present" do
    right = Authorization::Right.new

    assert right.invalid?
    assert !right.save, "Should fail as controller and action are not present."
  end

  test 'Name is optional' do
    right = Authorization::Right.new :action => 'pages', :controller => 'show'

    assert right.valid?
    assert right.save, "Should pass as name is optional."
  end
end
