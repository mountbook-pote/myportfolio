class UsersController < ApplicationController
  before_action :set_user

  def show
    @posts = @user.posts.includes(:met_object).
      order(created_at: :desc)

    # current_userが@userの投稿をいいねしているか判定するために使用(N+1対策)
    @current_user_favorite_post_ids = current_user&.
      pluck_favorite_post_ids(@posts) || []
  end

  def favorites
    @favorite_posts = @user.favorite_posts.
      includes(:met_object, user: { image_attachment: :blob }).
      order(created_at: :desc)

    @current_user_favorite_post_ids = current_user&.
      pluck_favorite_post_ids(@favorite_posts) || []
  end

  def delete_icon
    @user.image.purge
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
