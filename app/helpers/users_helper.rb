module UsersHelper
  def favorited_by_users_count(user)
    favorited_sum = 0
    user.posts.each do |post|
      favorited = post.favorited_by_users.count
      favorited_sum += favorited
    end
    favorited_sum
  end
end
