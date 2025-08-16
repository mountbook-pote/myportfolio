FactoryBot.define do
  factory :met_object do
    object_id { 123456 }
    department { "European Paintings" }
    title { "test_title" }
    artist_display_name { "test_display_name" }
    object_date { "2025" }
    primary_image_small { "https://example.com/image_small.jpg" }
    object_url { "https://metmuseum.org/art/collection/search/123456" }
  end
end
