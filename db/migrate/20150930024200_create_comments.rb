class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :title
      t.string :content
      t.integer :status
      t.timestamps null: false
      # foreign key.  belongs_to user, post.
      t.integer :user_id
      t.integer :post_id
    end
    
  end
end
