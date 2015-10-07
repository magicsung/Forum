class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin
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

  def user_params
    params.require(:user).permit( :name, :email, :about, :role )
  end

  def set_user
    @user = User.find( params[:id] )
  end

end
