require 'test_helper'

class Authorization::RoleTest < ActiveSupport::TestCase
  test "Name must be present" do
    role = Authorization::Role.new

    assert role.invalid?
    assert !role.save, "Should fail as name is not present."
  end

  test "Name must be unique" do
    valid_role    = Authorization::Role.create :name => "test_name"
    invalid_role  = Authorization::Role.new :name => "test_name"

    assert invalid_role.invalid?
    assert !invalid_role.save, "Should fail as the name has already been taken."
  end
end
