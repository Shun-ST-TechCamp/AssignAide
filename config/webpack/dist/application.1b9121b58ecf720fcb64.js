/******/ (function() { // webpackBootstrap
/******/ 	var __webpack_modules__ = ({

/***/ "./app/javascript/packs/edit_schedule.js":
/*!***********************************************!*\
  !*** ./app/javascript/packs/edit_schedule.js ***!
  \***********************************************/
/***/ (function() {

document.addEventListener("DOMContentLoaded", function () {
  var scheduleDataDiv = document.getElementById('schedule_data');
  var workdaySelect = document.getElementById('schedule_workday_id');
  if (!workdaySelect || !scheduleDataDiv) {
    return; // 必要な要素が存在しなければ処理を中止
  }

  // data-cast-id属性から現在のキャストIDを取得
  var currentCastId = scheduleDataDiv.getAttribute('data-cast-id');
  function updateWorkdays(castId) {
    fetch("/get_workdays_for_cast?cast_id=".concat(castId)).then(function (response) {
      return response.json();
    }).then(function (data) {
      workdaySelect.innerHTML = '';
      data.forEach(function (workday) {
        var option = new Option(workday.date, workday.id);
        workdaySelect.appendChild(option);
      });
    });
  }

  // 初期のキャストIDに基づいてworkdayをフィルタリング
  updateWorkdays(currentCastId);
});

/***/ }),

/***/ "./app/javascript/packs/image_preview.js":
/*!***********************************************!*\
  !*** ./app/javascript/packs/image_preview.js ***!
  \***********************************************/
/***/ (function() {

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

/***/ })

/******/ 	});
/************************************************************************/
/******/ 	// The module cache
/******/ 	var __webpack_module_cache__ = {};
/******/ 	
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/ 		// Check if module is in cache
/******/ 		var cachedModule = __webpack_module_cache__[moduleId];
/******/ 		if (cachedModule !== undefined) {
/******/ 			return cachedModule.exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = __webpack_module_cache__[moduleId] = {
/******/ 			// no module.id needed
/******/ 			// no module.loaded needed
/******/ 			exports: {}
/******/ 		};
/******/ 	
/******/ 		// Execute the module function
/******/ 		__webpack_modules__[moduleId](module, module.exports, __webpack_require__);
/******/ 	
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/ 	
/************************************************************************/
/******/ 	/* webpack/runtime/compat get default export */
/******/ 	!function() {
/******/ 		// getDefaultExport function for compatibility with non-harmony modules
/******/ 		__webpack_require__.n = function(module) {
/******/ 			var getter = module && module.__esModule ?
/******/ 				function() { return module['default']; } :
/******/ 				function() { return module; };
/******/ 			__webpack_require__.d(getter, { a: getter });
/******/ 			return getter;
/******/ 		};
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/define property getters */
/******/ 	!function() {
/******/ 		// define getter functions for harmony exports
/******/ 		__webpack_require__.d = function(exports, definition) {
/******/ 			for(var key in definition) {
/******/ 				if(__webpack_require__.o(definition, key) && !__webpack_require__.o(exports, key)) {
/******/ 					Object.defineProperty(exports, key, { enumerable: true, get: definition[key] });
/******/ 				}
/******/ 			}
/******/ 		};
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/hasOwnProperty shorthand */
/******/ 	!function() {
/******/ 		__webpack_require__.o = function(obj, prop) { return Object.prototype.hasOwnProperty.call(obj, prop); }
/******/ 	}();
/******/ 	
/******/ 	/* webpack/runtime/make namespace object */
/******/ 	!function() {
/******/ 		// define __esModule on exports
/******/ 		__webpack_require__.r = function(exports) {
/******/ 			if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 				Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 			}
/******/ 			Object.defineProperty(exports, '__esModule', { value: true });
/******/ 		};
/******/ 	}();
/******/ 	
/************************************************************************/
var __webpack_exports__ = {};
// This entry need to be wrapped in an IIFE because it need to be in strict mode.
!function() {
"use strict";
/*!*********************************************!*\
  !*** ./app/javascript/packs/application.js ***!
  \*********************************************/
__webpack_require__.r(__webpack_exports__);
/* harmony import */ var _image_preview__WEBPACK_IMPORTED_MODULE_0__ = __webpack_require__(/*! ./image_preview */ "./app/javascript/packs/image_preview.js");
/* harmony import */ var _image_preview__WEBPACK_IMPORTED_MODULE_0___default = /*#__PURE__*/__webpack_require__.n(_image_preview__WEBPACK_IMPORTED_MODULE_0__);
/* harmony import */ var _edit_schedule__WEBPACK_IMPORTED_MODULE_1__ = __webpack_require__(/*! ./edit_schedule */ "./app/javascript/packs/edit_schedule.js");
/* harmony import */ var _edit_schedule__WEBPACK_IMPORTED_MODULE_1___default = /*#__PURE__*/__webpack_require__.n(_edit_schedule__WEBPACK_IMPORTED_MODULE_1__);


}();
/******/ })()
;
//# sourceMappingURL=application.1b9121b58ecf720fcb64.js.map