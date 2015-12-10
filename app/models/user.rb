class User < ActiveRecord::Base
    
    has_many :shoppingCartItems, dependent: :destroy
    has_many :userProductFavorites, dependent: :destroy
    
    # Field validations
    validates :username, presence: true
    validates_uniqueness_of :username
    validates :email, presence: true
    validates :password, presence: true, confirmation: true
    # validates :password_confirmation, presence: true
    
    # Default sort by username
    default_scope { order('username ASC') }
    
    def cart_total_price
        @cartItemSum = 0
        self.shoppingCartItems.each do |item|
            @cartItemSum += (item.product.price * item.quantity)
        end
        @cartItemSum
    end
    
    def has_item_in_cart(productId)
        !ShoppingCartItem.where(:user_id => self.id, :product_id => productId).take.nil?
    end
    
    def has_item_favorited(productId)
        !UserProductFavorite.where(:user_id => self.id, :product_id => productId).take.nil?
    end
    
    def favorite_products
        Product.where(id: UserProductFavorite.where(:user_id => self.id).pluck(:product_id))
    end
end