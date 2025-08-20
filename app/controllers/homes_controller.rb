class HomesController < ApplicationController
  FETCH_NUMBER = 6

  def top
    @posts = Post.includes(:favorites, :met_object, user: { image_attachment: :blob }).
      order(created_at: :desc).
      limit(FETCH_NUMBER)

    @current_user_favorite_post_ids = if current_user
      current_user.favorites.where(post_id: @posts.map(&:id)).pluck(:post_id)
    else
      []
    end
  end

  def about
  end

  def terms
  end

  def policy
  end
end
