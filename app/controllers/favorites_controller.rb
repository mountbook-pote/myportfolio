class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    favorite = current_user.favorites.new(post_id: @post.id)
    favorite.save

    @post.reload # postのいいね数(DB上)を反映させるために必要

    # 現在のユーザのいいねしているidのうち、この投稿分だけを新たに取得する。
    @current_user_favorite_post_ids = current_user.pluck_favorite_post_ids_for_js(@post)

    respond_to do |format|
      format.js # HTMLのリダイレクトの代わりにcreate.js.erbを返す
    end
  end

  def destroy
    favorite = current_user.favorites.find_by(post_id: @post.id)
    favorite.destroy

    @post.reload

    # 現在のユーザのいいねしているidのうち、この投稿分だけを削除する。
    @current_user_favorite_post_ids = current_user.pluck_favorite_post_ids_for_js(@post)

    respond_to do |format|
      format.js # HTMLのリダイレクトの代わりにdestroy.js.erbを返す
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end
end
