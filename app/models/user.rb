class User < ApplicationRecord #note how it inherits from Application Record (which inherits from ActiveRecord::Base)
    before_create {self.email = email.downcase} #note -- this is an activerecord callback
    has_many :microposts
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #note how it is completely fine to declare a variable above a validatioin
    validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: true
end

#note how we confirmed that it inherits from active record base in the terminal ---> ApplicationRecord < ActiveRecord::Base
#note the valid method to test whether or not an instance is valid --> hartl.valid?
#note --> there is a difference between creating an object in memory and touching the database
#note --> destroy will remove the object from the database (but it is still kept in memeory)
#note the use of --> user.errors.full_messages
#note the use of the lenght validation (and how we need a hash)
#note how we can create a custom message
#note when rails will infer something to be true
#compare password (hashed) to the result stored in the database