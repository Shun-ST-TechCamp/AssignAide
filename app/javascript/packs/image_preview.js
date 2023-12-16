document.addEventListener("turbo:load", function() {
  document.querySelector('#image-input').addEventListener('change', function(e) {
    let file = e.target.files[0];
    let reader = new FileReader();

    reader.onload = function(e) {
      let preview = document.querySelector('#image-preview');
      preview.innerHTML = '<img src="' + e.target.result + '" class="preview-image" style="max-width: 200px; max-height: 200px;" />';
    };

    if (file) {
      reader.readAsDataURL(file);
    } else {
      preview.innerHTML = '';
    }
  });
});