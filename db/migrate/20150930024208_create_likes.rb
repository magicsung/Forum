class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.timestamps null: false
      # foreign key.  belongs_to user, post.
      t.intrger :user_id
      t.intrger :post_id
    end
  end
end
