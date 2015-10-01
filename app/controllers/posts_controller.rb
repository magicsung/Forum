class PostsController < ApplicationController

  before_action :set_post, :only => [ :show, :edit, :update, :destroy ]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new( post_params )
    
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



  private

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def set_post
    @post = Post.find( params[:id] )
  end

end
