require "application_system_test_case"

class LandingPagesTest < ApplicationSystemTestCase
  test "visiting the landing page" do
    visit root_url

    # Verify page title and content
    assert_selector "span", text: "Summit"
    assert_selector "h1", text: "A personal compass for life"
    assert_selector "p", text: "Track your health, habits, and happiness with clarity"

    # Verify navigation links
    assert_link "Log in"
    assert_link "Sign up"

    # Verify CTA button
    assert_link "Get Started"

    # Verify mountain background is present
    assert_selector "img[alt='Mountains']"
  end

  test "responsive design breakpoints" do
    visit root_url

    # Test mobile view
    using_window_size(375, 667) do # iPhone SE size
      assert_selector ".min-h-screen" # Verify full height is maintained
      assert_selector "h1.text-4xl" # Check mobile text size
    end

    # Test tablet view
    using_window_size(768, 1024) do # iPad size
      assert_selector ".min-h-screen"
      assert_selector "h1[class*='sm:text-5xl']" # Check tablet/desktop text size
    end

    # Test desktop view
    using_window_size(1440, 900) do # Standard desktop
      assert_selector ".min-h-screen"
      assert_selector "h1[class*='sm:text-5xl']"
    end
  end

  test "navigation functionality" do
    visit root_url

    # Test login link
    click_on "Log in"
    assert_current_path new_user_session_path

    # Test signup link
    visit root_url
    click_on "Sign up"
    assert_current_path new_user_registration_path

    # Test CTA button
    visit root_url
    click_on "Get Started"
    assert_current_path new_user_registration_path
  end

  private

  def using_window_size(width, height)
    current_window = page.driver.browser.manage.window
    original_size = current_window.size
    current_window.resize_to(width, height)
    yield
  ensure
    current_window.resize_to(original_size.width, original_size.height)
  end
end
