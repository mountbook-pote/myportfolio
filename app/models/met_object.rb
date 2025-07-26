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
        selected << record
        break if selected.size >= fetch_number
      end
      met_works += selected
    end
    met_works
  end
end
