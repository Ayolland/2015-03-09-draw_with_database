function boot(){
  pallette = ["#D7E894","#AEC440","#204631"];
  highSwatch = document.getElementById("highlight");
  midSwatch = document.getElementById("midtone");
  shadSwatch = document.getElementById("shadow");
  rowsArray = document.getElementById("grid").children;
  saveButton = document.getElementById("save_button");
  nameField = document.getElementById("name_field");
  
  highSwatch.addEventListener("click",setPointer);
  midSwatch.addEventListener("click",setPointer);
  shadSwatch.addEventListener("click",setPointer);
  
  // rowsArray[0].children[0].addEventListener("click",setPixel);
  for (y = 0; y < rowsArray.length; y ++){
    for (x = 0; x < rowsArray[y].children.length; x++){
      rowsArray[y].children[x].addEventListener("click",setPixel);
    }
  };
  
  setSwatches();
  clearPixels();
  pointerColor = pallette[1]
}

window.onload = boot;

function setSwatches(){
  highSwatch.style.background = pallette[0];
  midSwatch.style.background = pallette[1];
  shadSwatch.style.background = pallette[2];
}

function clearPixels(){
  pointerColor = pallette[0];
  for (y = 0; y < rowsArray.length; y ++){
    for (x = 0; x < rowsArray[y].children.length; x++){
      setPixel(rowsArray[y].children[x]);
    }
  };
}

function setPointer(){
  pointerColor = this.style.background
}

function setPixel(){
  this.style.background = pointerColor
}

function captureDrawing(){
  var string = "?name=" + nameField.value;
  for (y = 0; y < rowsArray.length; y ++){
    for (x = 0; x < rowsArray[y].children.length; x++){
      var str_value;
      var cellId = "x" + String(x) + "y" + String(y);
      var cellElement = document.getElementById(cellId);
      for (i = 0; i < pallette.length; i++){
        if (cellElement.style.background === pallette[i]){str_value = String(i);
        } else { console.log("COLOR MISSING");
        str_value = 0};
      }
      string = string + "&" + cellId + "=" + str_value;
    }
  }
  return string
}