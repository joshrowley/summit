require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    User.destroy_all
    @authorized_email = ENV["AUTHORIZED_EMAIL"] || "authorized@example.com"
    @unauthorized_email = "other@example.com"
    @password = "password123"
  end

  test "should create user with authorized email" do
    user = User.new(
      email: @authorized_email,
      password: @password,
      password_confirmation: @password
    )
    assert user.valid?
    assert user.save
  end

  test "should not create user with unauthorized email" do
    user = User.new(
      email: @unauthorized_email,
      password: @password,
      password_confirmation: @password
    )
    assert_not user.valid?
    assert_includes user.errors[:email], "is not authorized to sign up"
  end

  test "should not create user with empty email" do
    user = User.new(
      email: "",
      password: @password,
      password_confirmation: @password
    )
    assert_not user.valid?
    assert_includes user.errors[:email], "is not authorized to sign up"
  end

  test "should not create user with nil email" do
    user = User.new(
      email: nil,
      password: @password,
      password_confirmation: @password
    )
    assert_not user.valid?
    assert_includes user.errors[:email], "is not authorized to sign up"
  end
end
