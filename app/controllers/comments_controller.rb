class CommentsController < ApplicationController

  before_action :authenticate_user!
  
  before_action :find_post, :only => [ :create, :edit, :update, :destroy ]
  before_action :find_comment, :only => [ :edit, :update, :destroy]


  def create
    @comment = @post.comments.new( comment_params )
    @comment.user = current_user

    if @comment.save
      @post.last_comment_time = @comment.created_at
      @post.save

      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def edit
  end

  def update
    # TODO    
    redirect_to post_path( @post )    
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html
      format.js
    end
  end

  protected

  def comment_params
    params.require(:comment).permit(:title, :content, :comcount, :status)
  end

  def find_post
    @post = Post.find( params[:post_id] )
  end


  def find_comment
    if current_user.admin?
      @comment = @post.comments.find( params[:id] )
    else
      @comment = @post.comments.where( :user_id => current_user.id ).find( params[:id] )
    end
  end


end



