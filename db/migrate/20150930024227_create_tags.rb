class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.timestamps null: false
    end
    # has_many post.
    add_index :post_tagships, :tag_id
  end
end
