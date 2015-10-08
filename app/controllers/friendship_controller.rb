class FriendshipController < ApplicationController

  before_action :authenticate_user!

  def create
    unless current_user.friendships.find_by_friend_id(find_friend)
      @friend = Friendship.new( :user_id => current_user.id, :friend_id => find_friend, :status => 1 )
      @friend.save
    end

    redirect_to :back
  end

  def update
    @ship = Friendship.find(params[:id])
    @ship.status = 3
    @ship.save
    @friend = Friendship.new( :user_id => current_user.id, :friend_id => @ship.user_id, :status => 3 )
    @friend.save
    redirect_to :back
  end

  def destroy
    @ship = Friendship.find(params[:id])
    @ship.status = 4
    @ship.save

    redirect_to :back
  end

  def reject
    @ship = Friendship.find(params[:id])
    @ship.status = 2
    @ship.save
    @friend = Friendship.new( :user_id => current_user.id, :friend_id => @ship.user_id, :status => 2 )
    @friend.save

    redirect_to :back
  end

  private

  def find_friend
    params[:id]
  end

end
