ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:foursquare] = OmniAuth::AuthHash.new(
  provider: 'foursquare',
  uid: '12345',
  info: {
    firstName: 'Test',
    lastName: 'User',
    photo: 'http://example.com/photo.jpg'
  },
  credentials: {
    token: 'mock_token',
    expires: false
  },
  extra: {
    raw_info: {
      id: '12345',
      firstName: 'Test',
      lastName: 'User',
      photo: 'http://example.com/photo.jpg'
    }
  }
)
