class PostsController < ApplicationController

  before_action :set_post, :only => [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all
    # sort by comments
    if (params[:order] == 'comments')
      @posts = Post.order('comcount DESC' )
    # sort by views
    elsif (params[:order] == 'views')
      @posts = Post.order('view DESC')
    # sort by create_time
    elsif (params[:order] == 'createtime')
      @posts = Post.order('created_at DESC')
    # sort by last_comment_time
    elsif (params[:order] == 'last_comment_time')
      @posts = Post.order('last_comment_time DESC')
    elsif (params[:order] == 'category')
      @posts = Post.order('category_id')
    elsif (params[:where] == 'category_pub')
      @posts = Post.where(category_id:1)
    elsif (params[:where] == 'category_club')
      @posts = Post.where(category_id:2)
    elsif (params[:where] == 'category_event')
      @posts = Post.where(category_id:3)
    end
  end

  def show
    @comment =  Comment.new( :post => @post ) #@comment = @post.comments.new
    @post_comments = @post.comments
    @post.view +=1
    @post.save
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new( post_params )
    @post.user_id = current_user.id
    
    if @post.save
      flash[:notice] = "Post was successfully created!"
      redirect_to :action => :index  
    else
      flash.now[:alert] = "Please enter something!"
      render "new"
    end
    
  end

  def edit
  end

  def update
    @post.update( post_params )

    redirect_to :action => :index
  end

  def destroy
    @post.destroy

    redirect_to :action => :index
  end

  def about
    render "about"
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :category_id)
  end

  def set_post
    @post = Post.find( params[:id] )
  end

end
