class AddCommentsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comcount, :integer, default: 0, null: false
  end
end
