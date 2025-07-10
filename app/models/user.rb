class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [ :foursquare ]

  validate :restrict_email_domain

  private

  def restrict_email_domain
    # Set the authorized email in ENV['AUTHORIZED_EMAIL']
    authorized_email = ENV["AUTHORIZED_EMAIL"] || "authorized@example.com"
    unless email == authorized_email
      errors.add(:email, "is not authorized to sign up")
    end
  end
end
