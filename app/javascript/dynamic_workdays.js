document.addEventListener("turbo:load", function() {
  let castSelect = document.getElementById('schedule_cast_id');
  let workdayInput = document.getElementById('schedule_workday_id'); 

  if (castSelect) {
    castSelect.addEventListener('change', function() {
      let castId = this.value;
      let todayDate = new Date().toISOString().slice(0, 10); 

      fetch(`/get_workdays_for_cast?cast_id=${castId}&date=${todayDate}`)
        .then(response => response.json())
        .then(data => {
          if (data.length > 0) {
            workdayInput.value = data[0].id; 
          }
        });
    });
  }
});