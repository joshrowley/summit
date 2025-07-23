require "test_helper"

class UserOauthConstraintsTest < ActiveSupport::TestCase
  test "unique constraint on provider and uid combination" do
    # Create first user
    User.create!(
      email: 'first@foursquare.com',
      provider: 'foursquare',
      uid: '12345',
      password: 'password123'
    )

    # Attempt to create duplicate should raise database constraint error
    assert_raises ActiveRecord::RecordNotUnique do
      User.create!(
        email: 'second@foursquare.com',
        provider: 'foursquare',
        uid: '12345', # Same UID and provider
        password: 'password123'
      )
    end
  end

  test "allows same uid with different provider" do
    # Create user with foursquare
    User.create!(
      email: 'first@foursquare.com',
      provider: 'foursquare',
      uid: '12345',
      password: 'password123'
    )

    # Should allow same uid with different provider
    assert_nothing_raised do
      User.create!(
        email: 'second@google.com',
        provider: 'google',
        uid: '12345', # Same UID, different provider
        password: 'password123'
      )
    end

    assert_equal 2, User.count
  end

  test "allows same provider with different uid" do
    # Create first foursquare user
    User.create!(
      email: 'first@foursquare.com',
      provider: 'foursquare',
      uid: '12345',
      password: 'password123'
    )

    # Should allow different uid with same provider
    assert_nothing_raised do
      User.create!(
        email: 'second@foursquare.com',
        provider: 'foursquare',
        uid: '67890', # Different UID, same provider
        password: 'password123'
      )
    end

    assert_equal 2, User.count
  end

  test "allows regular users without provider and uid" do
    authorized_email = ENV["AUTHORIZED_EMAIL"] || "authorized@example.com"
    
    # Create regular user without OAuth fields
    assert_nothing_raised do
      User.create!(
        email: authorized_email,
        password: 'password123'
      )
    end

    user = User.last
    assert_nil user.provider
    assert_nil user.uid
  end

  test "index exists on provider and uid columns" do
    # Check that the database index exists
    indexes = ActiveRecord::Base.connection.indexes('users')
    provider_uid_index = indexes.find { |index| index.columns.sort == ['provider', 'uid'] }
    
    assert provider_uid_index, "Index on [provider, uid] should exist"
    assert provider_uid_index.unique, "Index should be unique"
  end
end