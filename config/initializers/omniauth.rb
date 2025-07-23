OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true

# Configure CSRF protection based on environment
if Rails.env.test?
  OmniAuth.config.test_mode = true
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :foursquare, ENV["FOURSQUARE_CLIENT_ID"], ENV["FOURSQUARE_CLIENT_SECRET"],
           redirect_uri: ENV["FOURSQUARE_REDIRECT_URI"],
           scope: "read",
           provider_ignores_state: true
end