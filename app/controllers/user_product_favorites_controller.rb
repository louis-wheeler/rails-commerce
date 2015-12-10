class UserProductFavoritesController < ApplicationController
    
    def create
        @user = User.find(params[:user_id])
        @user_product_favorite = @user.userProductFavorites.create(user_product_favorites_params)
        redirect_to :back
    end
    
    def destroy
        @user_product_favorite = UserProductFavorite.where(:user_id => params[:user_id], :product_id => params[:product_id]).take
        @user_product_favorite.destroy
        redirect_to :back
    end
    
    private
        def user_product_favorites_params
            params.permit(:user_id, :product_id)
        end
    
end
