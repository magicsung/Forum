class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.timestamps null: false
      # foreign key.  belongs_to user, post.
      t.integer :user_id
      t.integer :post_id
    end
  end
end
