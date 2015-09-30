class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.integer :view, default: 0, null: false
      t.integer :status
      t.timestamps null: false
      # foreign key.  belongs_to user, category.
      t.integer :user_id
      t.integer :category_id
    end
    # has_many like, comment, tag.
    add_index :likes, :post_id
    add_index :comments, :post_id
    add_index :post_tagships, :post_id
  end
end
