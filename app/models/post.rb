class Post < ApplicationRecord
  belongs_to :user
  belongs_to :met_object
  has_many :favorites, dependent: :destroy
  has_many :favorited_by_users, through: :favorites, source: :user

  validates :comment, presence: true, length: { maximum: 140 }

  def self.search_with_ransack(params)
    if params[:q].present? && params[:q][:met_object_department_in].blank?
      return Post.none
    end

    Post.ransack(params[:q]).result # 一つの作品は一つのカテゴリしか持たないため、重複がないのでdistinctは外している
  end
end
