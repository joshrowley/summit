require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    User.destroy_all
    @authorized_email = ENV["AUTHORIZED_EMAIL"] || "authorized@example.com"
    @unauthorized_email = "other@example.com"
    @password = "password123"
  end

  test "should create user with authorized email" do
    user = User.new(
      email: @authorized_email,
      password: @password,
      password_confirmation: @password
    )
    assert user.valid?
    assert user.save
  end

  test "should not create user with unauthorized email" do
    user = User.new(
      email: @unauthorized_email,
      password: @password,
      password_confirmation: @password
    )
    assert_not user.valid?
    assert_includes user.errors[:email], "is not authorized to sign up"
  end

  test "should not create user with empty email" do
    user = User.new(
      email: "",
      password: @password,
      password_confirmation: @password
    )
    assert_not user.valid?
    assert_includes user.errors[:email], "is not authorized to sign up"
  end

  test "should not create user with nil email" do
    user = User.new(
      email: nil,
      password: @password,
      password_confirmation: @password
    )
    assert_not user.valid?
    assert_includes user.errors[:email], "is not authorized to sign up"
  end

  # OAuth-specific tests
  test "from_omniauth creates new user with valid auth data" do
    auth_hash = create_foursquare_auth_hash('12345', 'test@foursquare.com')
    
    user = User.from_omniauth(auth_hash)
    
    assert user.persisted?
    assert_equal 'foursquare', user.provider
    assert_equal '12345', user.uid
    assert_equal 'test@foursquare.com', user.email
    assert user.password.present?
  end

  test "from_omniauth finds existing user by provider and uid" do
    existing_user = User.create!(
      email: 'existing@foursquare.com',
      provider: 'foursquare',
      uid: '12345',
      password: 'password123'
    )
    
    auth_hash = create_foursquare_auth_hash('12345', 'different@foursquare.com')
    user = User.from_omniauth(auth_hash)
    
    assert_equal existing_user.id, user.id
    assert_equal 'existing@foursquare.com', user.email # Email should not change
  end

  test "from_omniauth creates user with fallback email when no email provided" do
    auth_hash = create_foursquare_auth_hash('12345', nil)
    
    user = User.from_omniauth(auth_hash)
    
    assert user.persisted?
    assert_equal '12345@foursquare.oauth', user.email
  end

  test "oauth_user should return true for users with provider and uid" do
    user = User.new(provider: 'foursquare', uid: '12345')
    assert user.send(:oauth_user?)
  end

  test "oauth_user should return false for regular users" do
    user = User.new(email: @authorized_email)
    assert_not user.send(:oauth_user?)
  end

  test "should skip email domain restriction for oauth users" do
    user = User.new(
      email: 'any@domain.com',
      provider: 'foursquare',
      uid: '12345',
      password: @password
    )
    assert user.valid?
  end

  test "should enforce email domain restriction for regular users" do
    user = User.new(
      email: @unauthorized_email,
      password: @password,
      password_confirmation: @password
    )
    assert_not user.valid?
    assert_includes user.errors[:email], "is not authorized to sign up"
  end

  private

  def create_foursquare_auth_hash(uid, email)
    OmniAuth::AuthHash.new({
      provider: 'foursquare',
      uid: uid,
      info: {
        firstName: 'Test',
        lastName: 'User',
        email: email
      },
      credentials: {
        token: 'mock_token'
      }
    })
  end
end
