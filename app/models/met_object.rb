class MetObject < ApplicationRecord
  has_many :posts, dependent: :destroy
  EXTRA_FETCH_NUMBER = 2

  def self.fetch_all_departments_works_at_random(all_department_names = [], fetch_each_number)
    total_met_works = []

    all_department_names.each do |department_name|
      records = where(department: department_name).
        where.not(primary_image_small: [nil, '']).
        order('RANDOM()').
        limit(fetch_each_number * EXTRA_FETCH_NUMBER)

      each_met_works = []
      records.each do |record|
        each_met_works << record
        break if each_met_works.size == fetch_each_number
      end
      total_met_works += each_met_works
    end
    total_met_works
  end

  def self.fetch_department_works_at_random(department_name, fetch_number)
    met_works = []

    records = MetObject.where(department: department_name).
      where.not(primary_image_small: [nil, '']).
      order('RANDOM()').
      limit(fetch_number * EXTRA_FETCH_NUMBER)

    records.each do |record|
      met_works << record
      break if met_works.size == fetch_number
    end
    met_works
  end
end
