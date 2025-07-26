class DepartmentsController < ApplicationController
  ALL_DEPARTMENT_NAMES = [
    "European Paintings",
    "Medieval Art",
    "Egyptian Art",
  ].freeze
  FETCH_EACH_NUMBER = 3
  FETCH_NUMBER = 8

  def all_works
    @met_works = MetObject.fetch_all_departments_works_at_random(ALL_DEPARTMENT_NAMES, FETCH_EACH_NUMBER)
  end

  def european_paintings
    @met_works = MetObject.fetch_department_works_at_random("European Paintings", FETCH_NUMBER)
  end

  def medieval_art
    @met_works = MetObject.fetch_department_works_at_random("Medieval Art", FETCH_NUMBER)
  end

  def egyptian_art
    @met_works = MetObject.fetch_department_works_at_random("Egyptian Art", FETCH_NUMBER)
  end
end
