class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  before_action :set_post, :only => [ :edit, :update, :destroy ]
  before_action :find_post, :only => [ :profile, :favorite, :like ]

  def index
    if params[:tag] 
      @tag = Tag.find_by_name( params[:tag] )
      @posts = @tag.posts.page(params[:page]).per(10).where(status:1).order('created_at DESC')
    elsif params[:cid] 
      @category = Category.find( params[:cid]  )
      @posts = @category.posts
    else
      @posts = Post.all
    end

    if (params[:order] == 'comments')
      @posts = @posts.order('comcount DESC')
    elsif (params[:order] == 'views')
      @posts = @posts.order('view DESC')
    elsif (params[:order] == 'createtime')
      @posts = @posts.order('id ASC')
    elsif (params[:order] == 'last_comment_time')
      @posts = @posts.order('last_comment_time DESC')
    elsif (params[:order] == 'category')
      @posts = @posts.order('category_id')
    else
      @posts = @posts.order('id DESC')
    end

    @posts = @posts.page(params[:page]).per(10).where(status:1)
  end

  def show
    @post = Post.where( :status => 1 ).find( params[:id] )

    @comment =  Comment.new( :post => @post ) 
    @post_comments = @post.comments

    # TODO: use cookie to dedup
    @post.view +=1
    @post.save
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new( post_params )
    @post.user = current_user
    
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

    if params[:destroy_file] == "1"
      @post.upload_file = nil
    end

    @post.update(post_params)
      
    flash[:notice] = "Post was updated!"
    redirect_to :action => :index      
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html
      format.js
    end      
  end

  def about
  end

  # TODO: move to users_controller or profiles_controller
  def profile
  end

  def favorite

    if @fav = current_user.favorites.find_by_post_id(@post.id)
      @fav.destroy
    else      
      @fav = Favorite.new( :post => @post, :user => current_user )
      @fav.save
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  def like

    if @like = current_user.likes.find_by_post_id(@post.id)
      @like.destroy
    else  
      @like = Like.new( :post => @post, :user => current_user )
      @like.save
    end
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def find_post
    @post = Post.find(params[:id])  
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id, :status, :upload_file, :tag_list)
  end

  def set_post
    if current_user.admin?
      @post = Post.find( params[:id] )
    else
      @post = current_user.posts.find( params[:id] )
    end
  end

end


