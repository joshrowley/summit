require "application_system_test_case"

class FoursquareAuthenticationTest < ApplicationSystemTestCase
  setup do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:foursquare] = OmniAuth::AuthHash.new({
      provider: 'foursquare',
      uid: '12345',
      info: {
        firstName: 'Test',
        lastName: 'User',
        email: 'test@foursquare.com'
      },
      credentials: {
        token: 'mock_token'
      }
    })
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test "user can sign in with Foursquare" do
    visit new_user_session_path
    
    # Click the Foursquare OAuth link
    click_link "Sign in with Foursquare"

    # Should be redirected and signed in successfully
    assert_current_path root_path
    assert_text "Successfully authenticated from Foursquare account"
    
    # Verify user was created
    user = User.find_by(provider: 'foursquare', uid: '12345')
    assert user.present?
    assert_equal 'test@foursquare.com', user.email
  end

  test "handles Foursquare OAuth failure" do
    OmniAuth.config.mock_auth[:foursquare] = :invalid_credentials
    
    visit new_user_session_path
    click_link "Sign in with Foursquare"
    
    # Should redirect back to sign in page with error
    assert_current_path new_user_session_path
    assert_text "Foursquare authentication failed"
  end

  test "existing OAuth user can sign in again" do
    # Create existing OAuth user
    existing_user = User.create!(
      email: 'existing@foursquare.com',
      provider: 'foursquare',
      uid: '12345',
      password: 'password123'
    )

    visit new_user_session_path
    click_link "Sign in with Foursquare"

    # Should sign in the existing user
    assert_current_path root_path
    assert_text "Successfully authenticated from Foursquare account"

    # Verify no duplicate user was created
    assert_equal 1, User.where(provider: 'foursquare', uid: '12345').count
  end

  test "OAuth user creation with missing email" do
    OmniAuth.config.mock_auth[:foursquare] = OmniAuth::AuthHash.new({
      provider: 'foursquare',
      uid: '12345',
      info: {
        firstName: 'Test',
        lastName: 'User',
        email: nil
      },
      credentials: {
        token: 'mock_token'
      }
    })

    visit new_user_session_path
    click_link "Sign in with Foursquare"

    # Should create user with fallback email
    assert_current_path root_path
    user = User.find_by(provider: 'foursquare', uid: '12345')
    assert user.present?
    assert_equal '12345@foursquare.oauth', user.email
  end

  test "OAuth user stays signed in across navigation" do
    visit new_user_session_path
    click_link "Sign in with Foursquare"

    # Should be signed in and redirected to root
    assert_current_path root_path
    assert_text "Successfully authenticated from Foursquare account"

    # Verify user is actually signed in by navigating around
    visit root_path
    assert_current_path root_path
    
    # User should be persisted in database
    user = User.find_by(provider: 'foursquare', uid: '12345')
    assert user.present?
  end

  test "OAuth button appears on sign in page" do
    visit new_user_session_path
    
    assert_link "Sign in with Foursquare"
    assert_selector "a[href*='/users/auth/foursquare']"
  end

  test "multiple OAuth providers can coexist" do
    # This test ensures our implementation doesn't break if more providers are added
    visit new_user_session_path
    
    # Should show Foursquare option
    assert_link "Sign in with Foursquare"
    
    # Should not show other providers that aren't configured
    assert_no_link "Sign in with Google"
    assert_no_link "Sign in with Facebook"
  end
end 