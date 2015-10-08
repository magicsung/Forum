class Friendship < ActiveRecord::Base

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  STATUS = { 1 => "send", 2 => "reject", 3 => "Friend", 4 => "remove" }

  def friendship_status
    STATUS[ self.status ]
  end

end
