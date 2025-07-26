class MetObject < ApplicationRecord
  # 予め指定したジャンルからランダムに指定枚取得
  def self.fetch_met_objects_at_random(department_names = [], fetch_number)
    met_works = []

    department_names.each do |department_name|
      records = where(department: department_name).
        order('RANDOM()').limit(fetch_number * 2)

      selected = []
      records.each do |record|
        next if record.primary_image_small.blank?
        selected << {
          work_object_id: record.object_id,
          work_title: record.title,
          work_artist: record.artist_display_name,
          work_image: record.primary_image_small,
          work_date: record.object_date,
          work_met_url: record.object_url,
          work_department: record.department
        }
        break if selected.size >= fetch_number
      end
      met_works += selected
    end
    met_works
  end
end
