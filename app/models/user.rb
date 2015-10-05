class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]


  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_uid( auth.uid )
    if user
      user.token = auth.credentials.token
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.uid = auth.uid
      existing_user.token = auth.credentials.token
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.uid = auth.uid
    user.token = auth.credentials.token
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.name = auth.info.name
    user.image = auth.info.image
    user.save!
    return user
  end

  


  validates_presence_of :name

  has_many :likes
  has_many :favorites
  has_many :posts
  has_many :categorys
  has_many :comments

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  ROLE = { "User" => 0, "Admin" => 1 }

  def role_name
    ROLE[ self.role ]
  end

end
