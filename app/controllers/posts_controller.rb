class PostsController < ApplicationController

  before_action :set_post, :only => [ :show, :edit, :update, :destroy ]

  def index
    @posts = pages
    # sort by comments
    if (params[:order] == 'comments')
      @posts = pages.order('comcount DESC')
    # sort by views
    elsif (params[:order] == 'views')
      @posts = pages.order('view DESC')
    # sort by create_time
    elsif (params[:order] == 'createtime')
      @posts = pages.order('created_at ASC')
    # sort by last_comment_time
    elsif (params[:order] == 'last_comment_time')
      @posts = pages.order('last_comment_time DESC')
    # sort by category
    elsif (params[:order] == 'category')
      @posts = pages.order('category_id')
    else
      @posts = pages.order('created_at DESC')
    end

    # Tag filter
    Tag.all.map do |x| 
      if (params[:where] == "tag_"+x.name)
        @posts = x.posts.page(params[:page]).per(10).where(status:1).order('created_at DESC')
      end
    end

    # Category filter
    Category.all.map do |x| 
      if (params[:where] == x.name)
        # filter & sort 
        if (params[:order] == 'comments')
          @posts = pages.where(category_id:x.id).order('comcount DESC')
        elsif (params[:order] == 'views')
          @posts = pages.where(category_id:x.id).order('view DESC')
        elsif (params[:order] == 'createtime')
          @posts = pages.where(category_id:x.id).order('created_at ASC')
        elsif (params[:order] == 'last_comment_time')
          @posts = pages.where(category_id:x.id).order('last_comment_time ASC')
        elsif (params[:order] == 'category')
          @posts = pages.where(category_id:x.id).order('category_id')  
        else
          @posts = pages.where(category_id:x.id).order('created_at DESC')
        end
      end
    end 
  end

  def show

    if @post.status == 1 # filter post status public
      @comment =  Comment.new( :post => @post ) #@comment = @post.comments.new
      # views count
      @post_comments = @post.comments
      @post.view +=1
      @post.save
    end

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
    # Owner or Admin can edit
    if @post.user_id == current_user.id or current_user.role == 1
    else
      flash[:alert] = "Permission denied!"
      redirect_to :action => :index
    end
  end

  def update

    if params[:destroy_file] == "1"
      @post.upload_file = nil
    end

    if @post.user_id == current_user.id
      @post.update( post_params )
      redirect_to :action => :index
      flash[:notice] = "Post was updated!"
    else
      flash[:alert] = "Permission denied!"
      redirect_to :action => :index
    end
  end

  def destroy
    # Owner or Admini can delete post
    if @post.user_id == current_user.id or current_user.role == 1
      @post.destroy
      flash[:notice] = "Post was deleted!"
    else
      flash[:alert] = "Permission denied!"
    end
    redirect_to :action => :index
  end

  def about
    render "about"
  end

  def profile
    @user = User.find(params[:id])
    render "profile"
  end

  def favorite
    if a = current_user.favorites.find_by_post_id(params[:id])
      a.destroy
      flash[:notice] = "Aleardy deleted!"
    else
      @post = Post.find(params[:id])
      @fav = Favorite.new
      @fav.post_id = @post.id
      @fav.user_id = current_user.id
      @fav.save
      flash[:notice] = "Added to favorite"
    end
    redirect_to :back
  end

  def like
    if a = current_user.likes.find_by_post_id(params[:id])
      a.destroy
    else
      @post = Post.find(params[:id])
      @lik = Like.new
      @lik.post_id = @post.id
      @lik.user_id = current_user.id
      @lik.save
    end
    redirect_to :back
  end


  private

  def pages
    Post.page(params[:page]).per(10).where(status:1) # filter post_status_public
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id, :status, :upload_file, :tag_list)
  end

  def set_post
    @post = Post.find( params[:id] )
  end

end


