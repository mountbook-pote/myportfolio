class RemoveFavoritesCountFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :favorites_count, :integer
  end
end
