class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :foursquare ]

  validate :restrict_email_domain, unless: :oauth_user?

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{auth.uid}@foursquare.oauth"
      user.provider = auth.provider
      user.uid = auth.uid
      # Generate a random password for OAuth users
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation! if user.respond_to?(:skip_confirmation!)
    end
  end

  private

  def oauth_user?
    provider.present? && uid.present?
  end

  def restrict_email_domain
    # Set the authorized email in ENV['AUTHORIZED_EMAIL']
    authorized_email = ENV["AUTHORIZED_EMAIL"] || "authorized@example.com"
    unless email == authorized_email
      errors.add(:email, "is not authorized to sign up")
    end
  end
end
