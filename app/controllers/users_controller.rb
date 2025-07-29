class UsersController < ApplicationController
  before_action :set_user
  def show
    @posts = @user.posts.includes(:met_object)
  end

  def favorites
    @favorite_posts = @user.favorite_posts.includes(:favorites, :met_object, user: { image_attachment: :blob })
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end
