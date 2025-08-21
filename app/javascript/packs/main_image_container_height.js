  function getTrimHeight() {
  if (window.innerWidth < 768) {
    return 0;
  } else if (window.innerWidth < 1152) {
    return 60; //sm-device-or-lessのトリミング分(px)
  } else {
    return 120; //それ以外のトリミング分(px)
  }
}

document.addEventListener('turbolinks:load', () => {
  // console.log('main_container_height loaded')
  const image = document.querySelector('.center-column-image');
  const centerColumn = document.querySelector('.center-column');

  if (!image || !centerColumn) return;

  function adjustHeightBasedOnDisplayedSize() {
    const displayedHeight = image.clientHeight;
    const adjustedHeight = displayedHeight - getTrimHeight();
    centerColumn.style.height = adjustedHeight + 'px';
  }

  image.addEventListener('load', adjustHeightBasedOnDisplayedSize);
  adjustHeightBasedOnDisplayedSize();
});

window.addEventListener('resize', () => {
  const image = document.querySelector('.center-column-image');
  const centerColumn = document.querySelector('.center-column');

  if (!image || !centerColumn) return;
  const displayedHeight = image.clientHeight;
  const adjustedHeight = displayedHeight - getTrimHeight();
  centerColumn.style.height = adjustedHeight + 'px';
});
