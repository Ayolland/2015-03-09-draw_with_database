function boot(){
  highColor = "white";
  midColor = "lightgray";
  shadColor = "slategray";
  pointerColor = midColor
  highSwatch = document.getElementById("highlight");
  midSwatch = document.getElementById("midtone");
  shadSwatch = document.getElementById("shadow");
  rowsArray = document.getElementById("grid").children;
  
  highSwatch.addEventListener("click",setPointer);
  midSwatch.addEventListener("click",setPointer);
  shadSwatch.addEventListener("click",setPointer);
  // rowsArray[0].children[0].addEventListener("click",setPixel);
  for (y = 0; y < rowsArray.length; y ++){
    for (x = 0; x < rowsArray[y].children.length; x++){
      rowsArray[y].children[x].addEventListener("click",setPixel)
    }
  };
  
  setSwatches();
}

window.onload = boot;

function setSwatches(){
  highSwatch.style.background = highColor;
  midSwatch.style.background = midColor;
  shadSwatch.style.background = shadColor;
}

function setPointer(){
  pointerColor = this.style.background
}

function setPixel(){
  this.style.background = pointerColor
}