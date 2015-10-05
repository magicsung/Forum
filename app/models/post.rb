class Post < ActiveRecord::Base

  STATUS = { "Public" => 1, "Draft" => 2 }

  def status_name
    STATUS[ self.status ]
  end

  has_many :likes, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :post_tagships, :dependent => :destroy
  has_many :tags, :through => :post_tagships, :dependent => :destroy

  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :content, :user_id

end
