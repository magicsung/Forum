class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.timestamps null: false
      # foreign key.  belongs_to user, post.
      t.integer :user_id
      t.integer :post_id
    end
     add_index :likes, :post_id
  end
end
