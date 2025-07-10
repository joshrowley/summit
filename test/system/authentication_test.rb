require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
  setup do
    @authorized_email = ENV["AUTHORIZED_EMAIL"] || "authorized@example.com"
    @unauthorized_email = "other@example.com"
    @password = "password123"
  end

  teardown do
    User.destroy_all
  end

  test "authorized user can sign up" do
    visit root_path
    click_link "Sign up"

    fill_in "Email", with: @authorized_email
    fill_in "Password", with: @password
    fill_in "Password confirmation", with: @password
    click_button "Sign up"

    assert_text "Welcome! You have signed up successfully."
    assert_text "Welcome, #{@authorized_email}"
  end

  test "unauthorized user cannot sign up" do
    visit root_path
    click_link "Sign up"

    fill_in "Email", with: @unauthorized_email
    fill_in "Password", with: @password
    fill_in "Password confirmation", with: @password
    click_button "Sign up"

    assert_text "Email is not authorized to sign up"
    assert_no_text "Welcome, #{@unauthorized_email}"
  end

  test "user can sign in and sign out" do
    # First create a user
    User.create!(email: @authorized_email, password: @password, password_confirmation: @password)

    # Sign in
    visit root_path
    click_link "Log in"

    fill_in "Email", with: @authorized_email
    fill_in "Password", with: @password
    click_button "Log in"

    assert_text "Welcome, #{@authorized_email}"

    # Sign out
    click_button "Sign out"
    assert_no_text "Welcome, #{@authorized_email}"
    assert_text "Log in"
  end

  test "homepage shows correct links based on authentication status" do
    # When not signed in
    visit root_path
    assert_text "Log in"
    assert_text "Sign up"
    assert_no_text "Sign out"

    # When signed in
    user = User.create!(email: @authorized_email, password: @password, password_confirmation: @password)
    sign_in user

    visit root_path
    assert_no_text "Log in"
    assert_no_text "Sign up"
    assert_text "Sign out"
    assert_text "Welcome, #{@authorized_email}"
  end
end
