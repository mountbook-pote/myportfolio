class Post < ApplicationRecord
  belongs_to :user
  belongs_to :met_object

  validates :comment, presence: true, length: { maximum: 140 }
end
