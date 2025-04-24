require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_url
    assert_response :success
    assert_select "title", "Summit"
  end

  test "should have proper meta tags" do
    get root_url
    assert_response :success
    assert_select "meta[name='viewport']"
    assert_select "meta[name='apple-mobile-web-app-capable']"
    assert_select "meta[name='mobile-web-app-capable']"
  end

  test "should include required assets" do
    get root_url
    assert_response :success
    assert_select "link[rel='stylesheet'][href*='app']"
    assert_select "script[src*='application']"
  end
end 