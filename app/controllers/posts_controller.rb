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
      @posts = pages.order('created_at DESC')
    # sort by last_comment_time
    elsif (params[:order] == 'last_comment_time')
      @posts = pages.order('last_comment_time DESC')
    # sort by category
    elsif (params[:order] == 'category')
      @posts = pages.order('category_id')  
    end

    # filter
    Category.all.map do |x| 
      if (params[:where] == 'category_'+x.name)
        @posts = pages.where(category_id:x.id)
      end
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
    if @post.user_id == current_user.id
    else
      flash[:alert] = "You are not author!!!"
      redirect_to :action => :index
    end
  end

  def update
    if @post.user_id == current_user.id
      @post.update( post_params )
      redirect_to :action => :index
    else
      flash[:alert] = "You are not author!!!"
      redirect_to :action => :index
    end
  end

  def destroy
    if @post.user_id == current_user.id
      @post.destroy
    else
      flash[:alert] = "You are not author!!!"
    end
    

    redirect_to :action => :back
  end

  def about
    render "about"
  end

  def profile
    @user = User.find(params[:id])
    render "profile"
  end

  def favorite
    if current_user.favorites.find_by_post_id(@post)
      flash[:alert] = "Aleardy added!!!"
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


  private

  def pages
    Post.page(params[:page]).per(10).where(status:1) # filter post_status_public
  end

  def post_params
    params.require(:post).permit(:title, :content, :category_id, :status)
  end

  def set_post
    @post = Post.find( params[:id] )
  end

end


