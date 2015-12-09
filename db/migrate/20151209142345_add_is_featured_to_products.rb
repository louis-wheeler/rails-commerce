class AddIsFeaturedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :isFeatured, :boolean
  end
end
