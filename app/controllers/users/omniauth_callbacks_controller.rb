class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :verify_authenticity_token, only: [:foursquare, :failure]

  def foursquare
    auth = request.env["omniauth.auth"]
    
    begin
      @user = User.from_omniauth(auth)
      
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: "Foursquare") if is_navigational_format?
        Rails.logger.info "Foursquare OAuth success for user #{@user.id}"
      else
        session["devise.foursquare_data"] = auth.except("extra")
        redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
      end
    rescue => e
      Rails.logger.error "Foursquare OAuth error: #{e.message}"
      redirect_to new_user_session_path, alert: "There was an error processing your Foursquare authentication."
    end
  end

  def failure
    Rails.logger.error "Foursquare OAuth failure: #{params[:message]}"
    redirect_to new_user_session_path, alert: "Foursquare authentication failed: #{params[:message]}"
  end
end
