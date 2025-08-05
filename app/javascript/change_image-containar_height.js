  function getTrimHeight() {
  if (window.innerWidth < 768) {
    return 0;         // スマホサイズ
  } else if (window.innerWidth < 1152) {
    return 60;        // タブレットサイズ
  } else {
    return 120;       // PCサイズ
  }
}

document.addEventListener('turbolinks:load', () => {
  const image = document.querySelector('.main-image');
  const centerColumn = document.querySelector('.center-column');

  function adjustHeightBasedOnDisplayedSize() {
    const displayedHeight = image.clientHeight;
    const adjustedHeight = displayedHeight - getTrimHeight();
    centerColumn.style.height = adjustedHeight + 'px';
  }

  image.addEventListener('load', adjustHeightBasedOnDisplayedSize);
  adjustHeightBasedOnDisplayedSize();
});

window.addEventListener('resize', () => {
  const image = document.querySelector('.main-image');
  const centerColumn = document.querySelector('.center-column');

  const displayedHeight = image.clientHeight;
  const adjustedHeight = displayedHeight - getTrimHeight();
  centerColumn.style.height = adjustedHeight + 'px';
});
