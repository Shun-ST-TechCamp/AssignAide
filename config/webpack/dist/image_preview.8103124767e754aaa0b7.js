/******/ (function() { // webpackBootstrap
/******/ 	/************************************************************************/
var __webpack_exports__ = {};
/*!***********************************************!*\
  !*** ./app/javascript/packs/image_preview.js ***!
  \***********************************************/
document.addEventListener('DOMContentLoaded', function () {
  document.querySelector('#image-input').addEventListener('change', function (e) {
    var file = e.target.files[0];
    var reader = new FileReader();
    reader.onload = function (e) {
      var preview = document.querySelector('#image-preview');
      preview.innerHTML = '<img src="' + e.target.result + '" class="preview-image" style="max-width: 200px; max-height: 200px;" />';
    };
    if (file) {
      reader.readAsDataURL(file);
    } else {
      preview.innerHTML = '';
    }
  });
});
/******/ })()
;
//# sourceMappingURL=image_preview.8103124767e754aaa0b7.js.map