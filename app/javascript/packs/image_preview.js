document.addEventListener("turbo:load", function() {
  const imageInput = document.querySelector('#image-input');

  if (imageInput) {
    imageInput.addEventListener('change', function(e) {
      let file = e.target.files[0];
      let reader = new FileReader();
      let preview = document.querySelector('#image-preview');

      reader.onload = function(e) {
        if (preview) {
          preview.innerHTML = '<img src="' + e.target.result + '" class="preview-image" />';
        }
      };

      if (file) {
        reader.readAsDataURL(file);
      } else if (preview) {
        preview.innerHTML = '';
      }
    });
  }
});