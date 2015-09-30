class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps null: false
      # foreign key.  create_by user. 
      t.integer :user_id
    end
    # has_many post.
    add_index :posts, :category_id
  end
end
