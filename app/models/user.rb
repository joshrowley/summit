class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validate :restrict_email_domain

  private

  def restrict_email_domain
    unless email == "joshua.f.rowley@gmail.com"
      errors.add(:email, "is not authorized to sign up")
    end
  end
end
