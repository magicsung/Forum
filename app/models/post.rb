class Post < ActiveRecord::Base

  has_many :likes
  has_many :comments
  has_many :post_tagships
  has_many :tags, :through => :post_tagships

  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :content, :user_id

end
