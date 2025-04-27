require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include Devise::Test::IntegrationHelpers

  if ENV["CI"]
    driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400], options: {
      args: ["--no-sandbox", "--disable-dev-shm-usage", "--user-data-dir=#{Dir.tmpdir}/chrome_#{Process.pid}"]
    }
  else
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end
end
