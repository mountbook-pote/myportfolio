class UsersController < ApplicationController
  before_action :set_user
  def show
    @posts = @user.posts.
      includes(:favorites, :met_object, user: { image_attachment: :blob }).
      order(created_at: :desc)

    # current_userが@userの投稿をいいねしているか判定するために使用(N+1対策)
    @current_user_favorite_post_ids = if current_user
      current_user.favorites.where(post_id: @posts.map(&:id)).pluck(:post_id)
    else
      [] # 未ログイン時の処理
    end
  end

  def favorites
    @favorite_posts = @user.favorite_posts.
      includes(:favorites, :met_object, user: { image_attachment: :blob }).
      order(created_at: :desc)
    
    @current_user_favorite_post_ids = if current_user
      current_user.favorites.where(post_id: @posts.map(&:id)).pluck(:post_id)
    else
      []
    end
  end

  def delete_icon
    @user.image.purge
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
