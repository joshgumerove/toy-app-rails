require "test_helper"

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
      @user = User.new(name: "Example User", email: "user@example.com", password: "foobar123", password_confirmation: "foobar123")
  end 

  test "should be valid" do 
      assert @user.valid?
  end

  test "name should be present" do
      @user.name = "  "
      assert_not @user.valid? #not the assert_not method (built-in)
  end

  test "email should be present" do
      @user.email = "  "
      assert_not @user.valid?
  end

  test "name should not be too long" do
      @user.name = "a" * 51
      assert_not @user.valid?
  end

  test "email should not be too long" do
      @user.email = "a" * 244 + "@example.com"
      assert_not @user.valid? #note these tests fail without doing something in user models file
  end

  test "email validation should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        assert @user.valid?, "#{valid_address.inspect} should be valid"
      end
  end

  test "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                            foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
          @user.email = invalid_address
          assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
        end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be at least seven characters" do
    invalid_passwords = %w[abc 12345 cool64]
    invalid_passwords.each do |invalid_password|
        @user.password = invalid_password
        assert_not @user.valid?, "#{invalid_password.inspect} should be invalid"
    end
  end

end

#note that this folder was automatically created
#note how we run the tests --> rails test:models 
#note how we can multiply strings in Ruby