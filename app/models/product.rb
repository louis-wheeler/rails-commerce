class Product < ActiveRecord::Base
    has_many :reviews, dependent: :destroy
    
    validates :name, presence: true
    validates :description, presence: true
    validates :price, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
