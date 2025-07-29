class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @favorite = current_user.favorites.find_by(post_id: @post.id)

    if @favorite.present?
      @favorite.destroy
      notice = 'いいねを取り消しました。'
    else
      @favorite = current_user.favorites.new(post: @post)
      if @favorite.save
        notice = 'いいねしました！'
      else
        notice = 'いいねできませんでした。'
      end
    end
    redirect_to posts_path(params[:post_id]), notice: notice
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
  end
end
