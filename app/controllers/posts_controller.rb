class PostsController < ApplicationController

  before_action :set_post, :only => [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.page(params[:page]).per(10)

    # sort by comments
    if (params[:order] == 'comments')
      @posts = Post.order('comcount DESC').page(params[:page]).per(10)
    # sort by views
    elsif (params[:order] == 'views')
      @posts = Post.order('view DESC').page(params[:page]).per(10)
    # sort by create_time
    elsif (params[:order] == 'createtime')
      @posts = Post.order('created_at DESC').page(params[:page]).per(10)
    # sort by last_comment_time
    elsif (params[:order] == 'last_comment_time')
      @posts = Post.order('last_comment_time DESC').page(params[:page]).per(10)
    elsif (params[:order] == 'category')
      @posts = Post.order('category_id').page(params[:page]).per(10)

    # filter
    elsif (params[:where] == 'category_pub')
      @posts = Post.where(category_id:1).page(params[:page]).per(10)
    elsif (params[:where] == 'category_club')
      @posts = Post.where(category_id:2).page(params[:page]).per(10)
    elsif (params[:where] == 'category_event')
      @posts = Post.where(category_id:3).page(params[:page]).per(10)
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

  def profile
    
    @user = User.find(params[:id])
    render "profile"
  end


  private

  def sort_params

  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id)
  end

  def set_post
    @post = Post.find( params[:id] )
  end

end


