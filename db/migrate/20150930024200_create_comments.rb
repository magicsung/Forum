class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.string :content
      t.intrger :status
      t.timestamps null: false
      # foreign key.  belongs_to user, post.
      t.intrger :user_id
      t.intrger :post_id
    end
    
  end
end
