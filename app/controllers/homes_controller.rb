class HomesController < ApplicationController
  ALL_DEPARTMENT_NAMES = [
    "European Paintings",
    "Medieval Art",
    "Egyptian Art",
  ].freeze
  FETCH_EACH_NUMBER = 3

  def top
    @met_works = MetObject.fetch_all_departments_works_at_random(ALL_DEPARTMENT_NAMES, FETCH_EACH_NUMBER)
  end
end
