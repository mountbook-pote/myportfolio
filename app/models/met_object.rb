class MetObject < ApplicationRecord
  # 予め指定したジャンルからランダムに指定枚取得
  def self.fetch_met_objects_at_random(department_names = [], fetch_number)
    met_objects = []

    department_names.each do |department_name|
      records = where(department: department_name).
        order('RANDOM()').limit(fetch_number * 2)

      selected = []
      records.each do |record|
        selected << {
          object_id: record.object_id,
          title: record.title,
          artist: record.artist_display_name,
          image: record.primary_image_small,
          object_date: record.object_date,
          object_URL: record.object_url,
          department: record.department
        }
        break if selected.size >= fetch_number
      end
      met_objects += selected
    end
    met_objects
  end
end
