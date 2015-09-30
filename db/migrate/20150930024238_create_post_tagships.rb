class CreatePostTagships < ActiveRecord::Migration
  def change
    create_table :post_tagships do |t|
      t.timestamps null: false
      # foreign key.  belongs_to post, tag.
      t.integer :post_id
      t.integer :tag_id
    end
    add_index :post_tagships, :post_id
    add_index :post_tagships, :tag_id
  end
end
