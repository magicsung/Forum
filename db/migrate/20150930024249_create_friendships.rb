class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :status
      t.timestamps null: false
      # foreign key.  belongs_to post, tag.
      t.integer :user_id
      t.integer :friend_id
    end
  end
end
