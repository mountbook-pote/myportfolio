class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save

    respond_to do |format|
      format.js  # HTMLのリダイレクトの代わりにcreate.js.erbを返す
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy
    respond_to do |format|
      format.js  # HTMLのリダイレクトの代わりにdestroy.js.erbを返す
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
