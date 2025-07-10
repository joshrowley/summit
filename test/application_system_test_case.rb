require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  Capybara.default_max_wait_time = 5

  if ENV["CI"]
    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ] do |options|
      options.add_argument("--no-sandbox")
      options.add_argument("--disable-dev-shm-usage")
      options.add_argument("--user-data-dir=#{Dir.tmpdir}/chrome_#{Process.pid}")
    end
  else
    driven_by :selenium, using: :chrome, screen_size: [ 1400, 1400 ]
  end
end
