function goToDepartment() {
  const selectDepartmentName = document.getElementById('department-id');
  const departmentID = selectDepartmentName.value;
    window.location.href = `/departments/${departmentID}`;
}

document.addEventListener('turbolinks:load', () => {
  const selectDepartmentButton = document.getElementById('select-department-button');
  selectDepartmentButton.addEventListener('click', goToDepartment);
});
