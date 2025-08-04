function goToDepartment() {
  const select = document.getElementById('department-id');
  const id = select.value;
    window.location.href = `/departments/${id}`;
}

document.addEventListener('turbolinks:load', () => {
  const button = document.getElementById('select-department-button');
  button.addEventListener('click', goToDepartment);
});
