class User < ApplicationRecord #note how it inherits from Application Record (which inherits from ActiveRecord::Base)
    has_many :microposts
    validates :name, :email, presence: true
end

#note how we confirmed that it inherits from active record base in the terminal ---> ApplicationRecord < ActiveRecord::Base
#note the valid method to test whether or not an instance is valid --> hartl.valid?
#note --> there is a difference between creating an object in memory and touching the database
#note --> destroy will remove the object from the database (but it is still kept in memeory)