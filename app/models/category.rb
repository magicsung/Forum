class Category < ActiveRecord::Base

  has_many :posts

  belongs_to :user

  validates_presence_of :name

end
