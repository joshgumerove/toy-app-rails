class User < ApplicationRecord #note how it inherits from Application Record
    has_many :microposts
    validates :name, :email, presence: true
end
