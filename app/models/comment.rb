class Comment < ActiveRecord::Base

  belongs_to :post, :counter_cache => "comcount"
  belongs_to :user

  validates_presence_of :title, :content

end
