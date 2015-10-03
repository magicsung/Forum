class CommentsController < ApplicationController

  before_action :find_post, :only => [ :create, :edit, :update, :destroy ]
  before_action :find_comment, :only => [ :edit, :update, :destroy]

  def new
    
  end

  def create

    @comment = @post.comments.new( comment_params )
    if @comment.save
      # comment count
      @post.comcount += 1
      # update comment_time to post
      @post.last_comment_time = @comment.created_at
      # who creat comment
      @comment.user_id = current_user.id
      @post.save
      @comment.save
      redirect_to post_path( @post )
    else
      render :action => :new
    end
  end

  def edit
    # Owner can edit comment
    if @comment.user_id == current_user.id
    else
      flash[:alert] = "You are not author!!!"
      redirect_to :back
    end
  end

  def update
    if @comment.user_id == current_user.id
      @comment.update( comment_params )
    else
      flash[:alert] = "You are not author!!!"
    end
    redirect_to post_path( @post )    
  end

  def destroy
    # Owner or Admin can delete comment
    if @comment.user_id == current_user.id or current_user.role == 1
      @comment.destroy
      @post.comcount -= 1
      @post.save
      flash[:notice] = "Comment was deleted !!"
    end
    redirect_to post_path( @post )
  end



  #private

  protected

  def comment_params
    params.require(:comment).permit(:title, :content, :comcount, :status)
  end

  def find_post
    @post = Post.find( params[:post_id] )
  end

  def find_comment
    @comment = @post.comments.find( params[:id] )
  end

end



