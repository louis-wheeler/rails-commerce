class AddCartSizeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cartSize, :integer
  end
end
