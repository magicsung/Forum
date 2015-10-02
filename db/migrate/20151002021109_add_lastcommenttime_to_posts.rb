class AddLastcommenttimeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :last_comment_time, :datetime
  end
end
