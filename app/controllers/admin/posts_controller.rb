class Admin::PostsController < ApplicationController

  before_action :authenticate_user!
  before_action :authenticate_admin

  def index
    @users = User.all
    @category = Category.new
  end

end
