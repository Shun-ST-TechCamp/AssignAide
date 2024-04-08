document.addEventListener("turbo:load", function() {
  let castSelect = document.getElementById('schedule_cast_id');
  let workdaySelect = document.getElementById('schedule_workday_id');
  let scheduleContainer = document.querySelector('.new_position_schedule_schedule_for_tomorrow');
  let isForTomorrow = scheduleContainer !== null;

  if (castSelect) {
    castSelect.addEventListener('change', function() {
      let castId = this.value;


      let date = new Date();
      if (isForTomorrow){
        date.setDate(date.getDate() + 1);
      }
      date.setMinutes(date.getMinutes() - date.getTimezoneOffset());
      let formattedDate = date.toISOString().slice(0, 10);

      fetch(`/for_cast_on_date?cast_id=${castId}&date=${formattedDate}`)
        .then(response => response.json())
        .then(data => {
          
          workdaySelect.innerHTML = '';

          data.forEach(function(workday) {
            var option = new Option(workday.date, workday.id);
            workdaySelect.appendChild(option);
          });
        })
        .catch(error => {
          console.error("申し訳ありませんが、問題が発生しました。ページを再読み込みしてください。");
        });
    });
  }
});