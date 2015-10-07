class AddScheduleToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :schedule, :datetime
    add_index :favorites, :user_id
    add_index :tags, :name
  end
end
