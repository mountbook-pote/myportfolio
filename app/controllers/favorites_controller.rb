class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @favorite = current_user.favorites.find_by(post_id: @post.id)

    if @favorite.present?
      @favorite.destroy
    else
      @favorite = current_user.favorites.new(post: @post)
      @favorite.save
    end
    # create.js.erbを探して実行するコード
    respond_to do |format|
      format.js
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
