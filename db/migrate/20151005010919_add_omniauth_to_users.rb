class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_index :users, :provider
    add_column :users, :uid, :string
    add_index :users, :uid
    add_column :users, :token, :string
    add_index :users, :token

    add_column :users, :image, :string
  end
end
