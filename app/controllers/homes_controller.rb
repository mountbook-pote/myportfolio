class HomesController < ApplicationController
  DEPARTMENT_NAMES = [
    "European Paintings",
    "Medieval Art",
    "Egyptian Art",
  ].freeze
  FETCH_NUMBER = 3

  def top
    @user = current_user
    @met_works = MetObject.
      fetch_met_objects_at_random(DEPARTMENT_NAMES, FETCH_NUMBER)
  end
end
