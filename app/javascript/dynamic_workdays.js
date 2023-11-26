document.addEventListener("turbo:load", function() {
  let castSelect = document.getElementById('schedule_cast_id');
  let workdaySelect = document.getElementById('schedule_workday_id');

  if (castSelect) {
    castSelect.addEventListener('change', function() {
      let castId = this.value;
      let todayDate = new Date().toISOString().slice(0, 10); // 当日の日付を YYYY-MM-DD 形式で取得

      // キャストIDと日付をパラメータとして渡す
      fetch(`/get_workdays_for_cast?cast_id=${castId}&date=${todayDate}`)
        .then(response => response.json())
        .then(data => {
          workdaySelect.innerHTML = '';

          data.forEach(function(workday) {
            var option = new Option(workday.date, workday.id);
            workdaySelect.appendChild(option);
          });
        });
    });
  }
});