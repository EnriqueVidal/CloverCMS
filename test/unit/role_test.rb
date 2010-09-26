require 'test_helper'

class RoleTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "Name must be present" do
    @role = Role.new
    assert !@role.save, "Should fail as name is not present."
  end
  
  test "Name must be unique" do
    @role   = Role.create :name => "test_name"
    @role2  = Role.new :name => "test_name"
    assert !@role2.save, "Should fail as the name has already been taken."
  end
end
