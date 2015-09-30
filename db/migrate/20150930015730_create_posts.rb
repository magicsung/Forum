class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.intrger :view
      t.intrger :status
      t.timestamps null: false
      # foreign key.  belongs_to user, category.
      t.intrger :user_id
      t.integer :category_id
    end
    # has_many like, comment, tag.
    add_index :like, :post_id
    add_index :comment, :post_id
    add_index :post_tagship, :post_id
  end
end
