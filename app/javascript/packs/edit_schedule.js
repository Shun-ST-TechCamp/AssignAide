document.addEventListener("DOMContentLoaded", function() {
  let scheduleDataDiv = document.getElementById('schedule_data');
  let workdaySelect = document.getElementById('schedule_workday_id');

  if (!workdaySelect || !scheduleDataDiv) {
    return; // 必要な要素が存在しなければ処理を中止
  }

  // data-cast-id属性から現在のキャストIDを取得
  let currentCastId = scheduleDataDiv.getAttribute('data-cast-id');

  function updateWorkdays(castId) {
    fetch(`/get_workdays_for_cast?cast_id=${castId}`)
      .then(response => response.json())
      .then(data => {
        workdaySelect.innerHTML = '';
        data.forEach(function(workday) {
          var option = new Option(workday.date, workday.id);
          workdaySelect.appendChild(option);
        });
      });
  }

  // 初期のキャストIDに基づいてworkdayをフィルタリング
  updateWorkdays(currentCastId);
});