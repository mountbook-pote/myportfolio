FactoryBot.define do
  factory :post do
    sequence(:comment) { |n| "test_comment_#{n}" }
    association :user
    association :met_object
  end
end
