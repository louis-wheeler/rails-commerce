class ProductsController < ApplicationController
    
    def index
        @products = Product.all
    end
    
    def show
        @product = Product.find(params[:id])
    end
    
    def new
        @product = Product.new
    end
    
    def edit
        confirm_admin
        @product = Product.find(params[:id])
    end
    
    def create
        confirm_admin
        @product = Product.new(product_params)
        if @product.save
            redirect_to @product
        else
            render 'new'
        end
    end
    
    def update
        confirm_admin
        @product = Product.find(params[:id])
        if @product.update(product_params)
            redirect_to @product
        else
            render 'edit'
        end
    end
    
    def destroy
        confirm_admin
        @product = Product.find(params[:id])
        @product.destroy
        redirect_to products_path
    end
    
    def confirm_admin
        if !logged_in? || (logged_in? && !current_user.isAdmin)
            redirect_to products_path
        end
    end
    
    private
        def product_params
            params.require(:product).permit(:name, :description, :price, :image)
        end
end