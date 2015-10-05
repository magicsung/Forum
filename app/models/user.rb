class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :name

  devise :omniauthable, :omniauth_providers => [:facebook]

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
