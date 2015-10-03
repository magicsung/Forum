class Admin::UsersController < ApplicationController

  before_action :authenticate
  before_action :set_user, :only => [ :edit, :update, :destroy]

  def edit
  end

  def update
    if @user.update( user_params )
      redirect_to admin_posts_path
    else
      flash.now[:alert] = "Update faild"
      render "edit"
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_posts_path
    else
      flash.now[:alert] = "Delete faild"
    end
  end


  protected

  def authenticate
    if current_user.role == 1
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

  def user_params
    params.require(:user).permit( :name, :email, :about, :role )
  end

  def set_user
    @user = User.find( params[:id] )
  end

end
