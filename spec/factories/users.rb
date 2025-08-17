FactoryBot.define do
  factory :user do
    name { "user_name" }
    email { "test@gmail.com" }
    password { "password" }
    trait :with_icon_image do
      after(:create) do |user|
        user.image.attach(
          io: File.open(Rails.root.join("spec/fixtures/sample.jpg")),
          filename: "sample.jpg",
          content_type: "image/jpg"
        )
      end
    end
  end
end
