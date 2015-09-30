class CreatePostTagships < ActiveRecord::Migration
  def change
    create_table :post_tagships do |t|
      t.timestamps null: false
      # foreign key.  belongs_to post, tag.
      t.intrger :post_id
      t.integer :tag_id
    end
  end
end
