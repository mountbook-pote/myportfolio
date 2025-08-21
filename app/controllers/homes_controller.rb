class HomesController < ApplicationController
  FETCH_NUMBER = 6

  def top
    @posts = Post.includes(:favorites, :met_object, user: { image_attachment: :blob }).
      order(created_at: :desc).
      limit(FETCH_NUMBER)

    @current_user_favorite_post_ids = current_user&.
      pluck_favorite_post_ids(@posts) || []
  end

  def about
  end

  def terms
  end

  def policy
  end
end
