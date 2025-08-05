const TRIM_HEIGHT = 140;

document.addEventListener('turbolinks:load', () => {
  const image = document.querySelector('.main-image');
  const centerColumn = document.querySelector('.center-column');

  function adjustHeightBasedOnDisplayedSize() {
    const displayedHeight = image.clientHeight;
    const adjustedHeight = displayedHeight - TRIM_HEIGHT;
    centerColumn.style.height = adjustedHeight + 'px';
  }

  image.addEventListener('load', adjustHeightBasedOnDisplayedSize);
  adjustHeightBasedOnDisplayedSize();
});

window.addEventListener('resize', () => {
  const image = document.querySelector('.main-image');
  const centerColumn = document.querySelector('.center-column');

  const displayedHeight = image.clientHeight;
  const adjustedHeight = displayedHeight - TRIM_HEIGHT;
  centerColumn.style.height = adjustedHeight + 'px';
});
