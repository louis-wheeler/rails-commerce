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
        @user = User.find(params[:id])
    end
    
    def create
        @user = User.new(user_params)
        @user.isAdmin = false
        
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
        if @user.update(user_params)
            redirect_to @user
        else
            render 'edit'
        end
    end
    
    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to root_path
    end
    
    private
        def user_params
            params.require(:user).permit(:username, :email, :password, :password_confirmation, :isAdmin)
        end
end
