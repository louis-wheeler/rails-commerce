class UsersController < ApplicationController
    
    # http_basic_authenticate_with name: @user.username, password: @user.password, except: [:index, :show]
    
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
        @user = User.find(params[:id])
        
        if !logged_in? || (logged_in? && current_user.username != @user.username)
            redirect_to users_path
        end
    end
    
    def create
        @user = User.new(user_params)
        @user.isAdmin = false
        if @user.image.nil?
            @user.image = 'no_image.jpg'
        end
        
        if @user.save
            log_in @user
            redirect_to root_path
        else
            flash.now[:danger] = 'All fields are required.  Ensure the password fields match.'
            render 'new'
        end
    end
    
    def update
        @user = User.find(params[:id])
        
        if !logged_in? || (logged_in? && current_user.username != @user.username)
            redirect_to users_path
            return
        end
        
        if @user.update(user_params)
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path
    end
    
    private
        def user_params
            params.require(:user).permit(:username, :email, :password, :password_confirmation, :isAdmin, :image)
        end
end
