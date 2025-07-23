class SwarmController < ApplicationController
  skip_forgery_protection only: :callback
  # Handles the OAuth callback from Foursquare
  def callback
    auth = request.env["omniauth.auth"]
    @access_token = auth["credentials"]["token"]
    @raw_info = auth["extra"]["raw_info"]
    # For now, just display the token and user info for validation
    render inline: <<-ERB
      <h1>Swarm OAuth Success</h1>
      <p><strong>Access Token:</strong> <%= @access_token %></p>
      <pre><%= JSON.pretty_generate(@raw_info) %></pre>
    ERB
  end

  # Handles OAuth failure
  def failure
    render inline: <<-ERB
      <h1>Swarm OAuth Failure</h1>
      <p><%= params[:message] %></p>
    ERB
  end
end
