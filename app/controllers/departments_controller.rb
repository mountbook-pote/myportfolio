class DepartmentsController < ApplicationController
  DEPARTMENT_IDS = {
    0 => "All Departments",
    1 => "European Paintings",
    2 => "Medieval Art",
    3 => "Egyptian Art",
  }.freeze

  FETCH_EACH_DEPARTMENT_NUMBER = 3
  FETCH_NUMBER = 9

  def show
    department_id = params[:id].to_i
    
    if department_id == 0
      @met_works = MetObject.
        fetch_all_departments_works_at_random(
          DEPARTMENT_IDS.values.reject { |name| name == "All Departments" }, 
          FETCH_EACH_DEPARTMENT_NUMBER
        )
    else
      @met_works = MetObject.
        fetch_department_works_at_random(DEPARTMENT_IDS[department_id], FETCH_NUMBER)
    end
    @department_name = DEPARTMENT_IDS[department_id]
  end
end
