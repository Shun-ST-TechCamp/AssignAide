document.addEventListener("DOMContentLoaded", function() {
  let castSelect = document.getElementById('schedule_cast_id');
  let workdaySelect = document.getElementById('schedule_workday_id'); // workday選択ボックスのIDを指定

  if (castSelect) {
    castSelect.addEventListener('change', function() {
      let castId = this.value;

      fetch(`/get_workdays_for_cast?cast_id=${castId}`)
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