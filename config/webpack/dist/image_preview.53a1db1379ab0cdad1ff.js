document.addEventListener("DOMContentLoaded",(function(){document.querySelector("#image-input").addEventListener("change",(function(e){var t=e.target.files[0],n=new FileReader;n.onload=function(e){document.querySelector("#image-preview").innerHTML='<img src="'+e.target.result+'" class="preview-image" style="max-width: 200px; max-height: 200px;" />'},t?n.readAsDataURL(t):preview.innerHTML=""}))}));
//# sourceMappingURL=image_preview.53a1db1379ab0cdad1ff.js.map