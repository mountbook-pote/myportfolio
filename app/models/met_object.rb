class MetObject < ApplicationRecord
  EXTRA_FETCH_NUMBER = 2

  def self.fetch_all_departments_works_at_random(all_department_names = [], fetch_each_number)
    total_met_works = []

    all_department_names.each do |department_name|
      records = where(department: department_name).
        order('RANDOM()').limit(fetch_each_number * EXTRA_FETCH_NUMBER)

      filtered_records = []
      records.each do |record|
        next if record.primary_image_small.blank?
        filtered_records << record
        break if filtered_records.size == fetch_each_number
      end
      total_met_works += filtered_records
    end
    total_met_works
  end

  def self.fetch_department_works_at_random(department_name, fetch_number)
    met_works = []

    records = MetObject.where(department: department_name).
      order('RANDOM()').limit(fetch_number * EXTRA_FETCH_NUMBER)

    filtered_records = []
    records.each do |record|
      next if record.primary_image_small.blank?
      filtered_records << record
      break if filtered_records.size == fetch_number
    end
    met_works = filtered_records
  end
end
