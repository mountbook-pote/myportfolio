class HomesController < ApplicationController
  FETCH_NUMBER = 6

  def top
    @posts = Post.includes(:met_object, user: { image_attachment: :blob }).
      order(created_at: :desc).
      limit(FETCH_NUMBER)
  end
end
