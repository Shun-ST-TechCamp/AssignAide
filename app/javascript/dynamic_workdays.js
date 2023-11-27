document.addEventListener("turbo:load", function() {
  let castSelect = document.getElementById('schedule_cast_id');
  let workdaySelect = document.getElementById('schedule_workday_id');

  if (castSelect) {
    castSelect.addEventListener('change', function() {
      let castId = this.value;

      // サーバータイムゾーンに合わせた日付を生成する方法に変更
      let todayDate = new Date();
      todayDate.setMinutes(todayDate.getMinutes() - todayDate.getTimezoneOffset());
      let formattedDate = todayDate.toISOString().slice(0, 10);

      fetch(`/for_cast_on_date?cast_id=${castId}&date=${formattedDate}`)
        .then(response => response.json())
        .then(data => {
          console.log('Response data:', data);
          workdaySelect.innerHTML = '';

          data.forEach(function(workday) {
            var option = new Option(workday.date, workday.id);
            workdaySelect.appendChild(option);
          });
        })
        .catch(error => {
          console.error('Error:', error);
        });
    });
  }
});