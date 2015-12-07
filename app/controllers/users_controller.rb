class UsersController < ApplicationController
    
    def index
        @users = User.all
    end
    
    def show
        @user = User.find(params[:id])
    end
    
    def new
        @user = User.new
    end
    
    def edit
        confirm_user
        @user = User.find(params[:id])
    end
    
    def create
        @user = User.new(user_params)
        @user.isAdmin = false
        @user.image = 'no_image.jpg'
        @user.cartSize = 0
        
        if @user.save
            log_in @user
            redirect_to root_path
        else
            flash.now[:danger] = 'All fields are required.  Ensure the password fields match.'
            render 'new'
        end
    end
    
    def update
        confirm_user
        @user = User.find(params[:id])
        
        if @user.update(user_params)
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def destroy
        confirm_user
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path
    end
    
    #def cart_total_price
    #    User.find(params[:id]).shopping_cart_items.sum(:product.price)
    #end
    
    def confirm_user
        if !logged_in? || (logged_in? && current_user.username != @user.username)
            redirect_to users_path
        end
    end
    
    private
        def user_params
            params.require(:user).permit(:username, :email, :password, :password_confirmation, :isAdmin, :image)
        end
end
