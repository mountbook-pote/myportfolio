function goToDepartment() {
  const selectDepartmentName = document.getElementById('department-id');
  const departmentID = selectDepartmentName.value;
    window.location.href = `/departments/${departmentID}`;
}

document.addEventListener('turbolinks:load', () => {
  console.log('select_department.js loaded')
  const selectDepartmentButton = document.getElementById('select-department-button');
  if (!selectDepartmentButton) return;
  selectDepartmentButton.addEventListener('click', goToDepartment);
});
