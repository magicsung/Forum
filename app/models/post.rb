class Post < ActiveRecord::Base

  STATUS = { "Public" => 1, "Draft" => 2 }

  has_many :likes, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :comments, :dependent => :destroy

  has_many :post_tagships, :dependent => :destroy
  has_many :tags, :through => :post_tagships

  belongs_to :user
  belongs_to :category

  validates_presence_of :title, :content, :user_id

  has_attached_file :upload_file, styles: { medium: "300x300>", thumb: "100x100>" }, 
                    default_url: "/images/:style/missing.png"
  validates_attachment_content_type :upload_file, content_type: /\Aimage\/.*\Z/

  def comment_users
    self.comments.map{ |c| c.user }.uniq
  end

  def status_name
    STATUS[ self.status ]
  end
  
  def tag_list
    self.tags.map{ |t| t.name }
  end

  def tag_list=(str)
    # arr = str .split(",")
    if str.first == ""
      str.shift 
    end

    self.tags = str.map do |t|
      tag = Tag.find_by_name(t)
      unless tag
        tag = Tag.create!( :name => t )
      end
      tag
    end

  end

end
