require "application_system_test_case"

class FoursquareAuthenticationTest < ApplicationSystemTestCase
  test "user can sign in with Foursquare" do
    visit root_path
    # Directly visit the OmniAuth path for Foursquare
    visit user_foursquare_omniauth_authorize_path

    # Should be redirected to the callback and see the success page
    assert_text "Foursquare OAuth Success"
    assert_text "Access Token:"
    assert_text "mock_token"
    assert_text "Test"
    assert_text "User"
  end
end 