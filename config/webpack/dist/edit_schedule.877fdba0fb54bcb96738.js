/******/ (function() { // webpackBootstrap
/******/ 	/************************************************************************/
var __webpack_exports__ = {};
/*!***********************************************!*\
  !*** ./app/javascript/packs/edit_schedule.js ***!
  \***********************************************/
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
/******/ })()
;
//# sourceMappingURL=edit_schedule.877fdba0fb54bcb96738.js.map