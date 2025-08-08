module PostsHelper
  def check_posts_empty(posts)
    return unless posts.empty?
    if !current_page?(favorites_user_path)
      "投稿はありません"
    else
      "いいねはありません"
    end
  end
end
