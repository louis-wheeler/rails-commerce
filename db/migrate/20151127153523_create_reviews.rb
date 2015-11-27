class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :user
      t.text :body
      t.decimal :rating
      t.references :product, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
