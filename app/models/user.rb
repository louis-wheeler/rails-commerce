class User < ActiveRecord::Base
    
    # Field validations
    validates :username, presence: true
    validates_uniqueness_of :username
    validates :email, presence: true
    validates :password, presence: true, confirmation: true
    # validates :password_confirmation, presence: true
    
    # Default sort by username
    default_scope { order('username ASC') }
    
end