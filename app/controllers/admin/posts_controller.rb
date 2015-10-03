class Admin::PostsController < ApplicationController

  before_action :authenticate

  def index
    @users = User.all
    @category = Category.new
  end



  protected

  def authenticate
    if current_user.role == 1
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
