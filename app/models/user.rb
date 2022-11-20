# frozen_string_literal: true

# NOTE: how it inherits from Application Record (which inherits from ActiveRecord::Base)
class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token # remeber attr_accessor is a method built into ruby

  before_create { self.email = email.downcase } # NOTE: -- this is an activerecord callback
  has_many :microposts, dependent: :destroy # if delete a user will now also delete all his microposts
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i # NOTE: how it is completely fine to declare a variable above a validatioin
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password
  before_create :create_activation_digest

  # NOTE: how we could also use self instead of capitalizing users
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost: cost)
  end

  # NOTE: how this is a class method
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def feed
    Micropost.where('user_id = ?', id)
  end

  # NOTE: how we can call this directly and it will assign the remember_digest (in our example was previously nil)
  def remember
    self.remember_token = User.new_token # will have access to this attribute outside the method
    update_attribute(:remember_digest, User.digest(remember_token)) # allows us to update a single attribute (note how we do not need to use self again after redifining it)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil) # reverses the remember method
  end
  # NOTE: the use of the private keyword

  def say_hello
    puts 'can run this in the rails console on an instance' # can see in the console
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    # update_attribute(:activated, true)
    # update_attribute(:activated_at, Time.zone.now)
    puts 'apply the updates'
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

  def create_activation_digest
    # create the token and digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end

# NOTE: how we confirmed that it inherits from
# active record base in the terminal ---> ApplicationRecord < ActiveRecord::Base
# note the valid method to test whether
# or not an instance is valid --> hartl.valid?
# note --> there is a difference between creating an object in memory and touching the database
# note --> destroy will remove the object
# from the database (but it is still kept in memeory)
# note the use of --> user.errors.full_messages
# note the use of the lenght validation (and how we need a hash)
# note how we can create a custom message
# note when rails will infer something to be true
# compare password (hashed) to the result stored in the database
# can authenticate users without storing the password themselves
# note what is meant by password_digest -- neads to be
# added as an attribute for has_secure_password to work
# note the syntax for creating a migration rails g migration
# add_password_digest_to_users password_digest:string
# note --> for has_secure_password to work we need to add bcrypt
# after adding has_secure_password -- tests will also fail again
# note how we cannot use dot syntax to assign values to hashes
# note that symbols are interpolated as strings
# note how we use instance variables in the controller
