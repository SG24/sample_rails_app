require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    # routes to signup page, not required, only for including proper flow
    get signup_path
    # tests for the presence for proper post url in the form before submission
    assert_select "form[action='/signup']"
    # compares the value of User.count before and after block execution (post users_path...)
    assert_no_difference "User.count" do
      post signup_path, params: { user: { name: "",
                                          email: "user@invalid",
                                          password: "foo",
                                          password_confirmation: "bar" } }
    end
    # checks that the failed submission above re-renders the new action
    assert_template "users/new"
    assert_select 'div#error_explanation', count: 1  # 1 div with this id
    assert_select "div.field_with_errors", count: 8  # 8 divs with this class, 2 for each user attribute
    assert_select "div.alert.alert-danger"  # ensures a div with these classes exist
    assert_select "li", "Name can't be blank"
    assert_select "li", "Email is invalid"
    assert_select "li", "Password confirmation doesn't match Password"
    assert_select "li", "Password is too short (minimum is 6 characters)"
  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Example User",
                                        email: "user@example.com",
                                        password: "password",
                                        password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template "users/show"
    # Just checking if the flash isn't empty as the test below is very specific and hence brittle
    # assert_select "div.alert.alert-success", "Welcome to the Sample App!"
    assert_not flash.empty?
  end

end
