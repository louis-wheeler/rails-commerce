class User < ActiveRecord::Base
    validates :username, presence: true
    validates_uniqueness_of :username
    validates :email, presence: true
    validates :password, presence: true, confirmation: true
    validates :password_confirmation, presence: true
end
