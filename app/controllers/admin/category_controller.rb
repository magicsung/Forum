class Admin::CategoryController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin
  before_action :set_category, :only => [ :update, :destroy ]

  def create
    @category = Category.new( category_params )
    if @category.save
       flash[:notice] = "Create category successed!!"
    end
    redirect_to admin_posts_path
  end

  def update
    if @category.update( category_params )
      flash[:notice] = "Rename category successed!!"
    else
      flash.now[:alert] = "rename faild!!"
    end
    redirect_to admin_posts_path
  end

  def destroy
    if @category.posts.size == 0
      @category.destroy
      flash[:notice] = "Destroy category successed!!"
    else
      flash[:alert] = "This category still have posts!!!"
    end
    redirect_to admin_posts_path
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find( params[:id] )
  end

end
