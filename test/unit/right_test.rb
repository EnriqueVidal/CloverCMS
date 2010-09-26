require 'test_helper'

class RightTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "Controller and Action must be present" do
    @right = Right.new
    assert !@right.save, "Should fail as controller and action are not present."
  end
  
  test 'Name is optional' do
    @right = Right.new :action => 'pages', :controller => 'show'
    assert @right.save, "Should pass as name is optional."
  end
end
