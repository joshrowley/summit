class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def verify_authenticity_token
    # no-op, needed to satisfy Rails 7.1+ callback checks
  end

  def foursquare
    auth = request.env['omniauth.auth']
    # For now, just display the token and user info for validation
    render inline: <<-ERB
      <h1>Foursquare OAuth Success</h1>
      <p><strong>Access Token:</strong> <%= auth['credentials']['token'] %></p>
      <pre><%= JSON.pretty_generate(auth) %></pre>
    ERB
  end

  def failure
    render inline: <<-ERB
      <h1>Foursquare OAuth Failure</h1>
      <p><%= params[:message] %></p>
    ERB
  end
end 