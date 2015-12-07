class Product < ActiveRecord::Base
    
    # Model relationships
    has_many :reviews, dependent: :destroy
    has_many :shopping_cart_items, dependent: :destroy
    
    # Field validations
    validates :name, presence: true
    validates :description, presence: true
    validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
    
    # Default sort by name
    default_scope { order('name ASC') }
    
end