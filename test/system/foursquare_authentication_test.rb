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
end 