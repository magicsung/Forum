class Post < ActiveRecord::Base

  STATUS = { "Public" => 1, "Draft" => 2 }

  def status_name
    STATUS[ self.status ]
  end

  has_many :likes
  has_many :favorites
  has_many :comments
  has_many :post_tagships
  has_many :tags, :through => :post_tagships

  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :content, :user_id

end
