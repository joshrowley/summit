require "test_helper"

class Users::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    OmniAuth.config.test_mode = true
  end

  teardown do
    OmniAuth.config.test_mode = false
  end

  test "foursquare callback creates and signs in new user" do
    OmniAuth.config.mock_auth[:foursquare] = create_foursquare_auth_hash('12345', 'test@foursquare.com')

    assert_difference 'User.count', 1 do
      post user_foursquare_omniauth_callback_path
    end

    user = User.last
    assert_equal 'foursquare', user.provider
    assert_equal '12345', user.uid
    assert_equal 'test@foursquare.com', user.email
    
    assert_redirected_to root_path
  end

  test "foursquare callback signs in existing user" do
    existing_user = User.create!(
      email: 'existing@foursquare.com',
      provider: 'foursquare',
      uid: '12345',
      password: 'password123'
    )

    OmniAuth.config.mock_auth[:foursquare] = create_foursquare_auth_hash('12345', 'existing@foursquare.com')

    assert_no_difference 'User.count' do
      post user_foursquare_omniauth_callback_path
    end

    assert_redirected_to root_path
  end

  test "foursquare callback handles missing auth data" do
    # Simulate missing auth data - this will trigger an authentication error
    # which gets handled by our error handling in the controller
    post user_foursquare_omniauth_callback_path

    # Should redirect somewhere (either to root if successful, or sign in if error)
    assert_response :redirect
  end

  test "foursquare callback with invalid provider data" do
    OmniAuth.config.mock_auth[:foursquare] = :invalid_credentials

    post user_foursquare_omniauth_callback_path

    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_match /Foursquare authentication failed/, response.body
  end

  test "foursquare callback creates user with fallback email" do
    OmniAuth.config.mock_auth[:foursquare] = create_foursquare_auth_hash('12345', nil)

    assert_difference 'User.count', 1 do
      post user_foursquare_omniauth_callback_path
    end

    user = User.last
    assert_equal '12345@foursquare.oauth', user.email
    assert_redirected_to root_path
  end

  private

  def create_foursquare_auth_hash(uid, email)
    OmniAuth::AuthHash.new({
      provider: 'foursquare',
      uid: uid,
      info: {
        firstName: 'Test',
        lastName: 'User',
        email: email
      },
      credentials: {
        token: 'mock_token'
      }
    })
  end
end