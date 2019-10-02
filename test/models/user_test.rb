require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com")
  end

  # should pass model validations
  test "should be valid" do
    assert @user.valid?
  end

  # blank names should not be valid, hence assert_not
  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  # blank emails should not be valid, @user.valid? should return false
  test "email should be present" do
    @user.email = "      "
    assert_not @user.valid?
  end

end
