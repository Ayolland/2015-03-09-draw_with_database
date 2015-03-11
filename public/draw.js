function boot(){
  palette = ["rgb(215, 232, 148)","rgb(174, 196, 64)","rgb(32, 70, 49)"];
  xHR = new XMLHttpRequest();
  highSwatch = document.getElementById("highlight");
  midSwatch = document.getElementById("midtone");
  shadSwatch = document.getElementById("shadow");
  rowsArray = document.getElementById("grid").children;
  saveButton = document.getElementById("save_button");
  nameField = document.getElementById("name_field");
  dropdown = document.getElementById("dropdown");
  loadButton = document.getElementById("load_button");
  clearButton = document.getElementById("clear_button");
  
  highSwatch.addEventListener("click",setPointer);
  midSwatch.addEventListener("click",setPointer);
  shadSwatch.addEventListener("click",setPointer);
  saveButton.addEventListener("click",saveDrawing);
  loadButton.addEventListener("click",loadDrawing);
  clearButton.addEventListener("click",clearPixels);
  
  
  
  for (y = 0; y < rowsArray.length; y ++){
    for (x = 0; x < rowsArray[y].children.length; x++){
      rowsArray[y].children[x].addEventListener("click",setPixel);
    }
  };
  
  setSwatches();
  clearPixels();
  pointerColor = palette[1]
}

window.onload = boot;

function setSwatches(){
  highSwatch.style.background = palette[0];
  midSwatch.style.background = palette[1];
  shadSwatch.style.background = palette[2];
}

function clearPixels(){
  pointerColor = palette[0];
  for (y = 0; y < rowsArray.length; y ++){
    for (x = 0; x < rowsArray[y].children.length; x++){
      setPixel.call(rowsArray[y].children[x]);
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
      var str_value =0 ;
      var cellId = "x" + String(x) + "y" + String(y);
      var cellElement = document.getElementById(cellId);
      for (i = 0; i < palette.length; i++){
        if (cellElement.style.background === palette[i]){str_value = String(i)}
      }
      string = string + "&" + cellId + "=" + str_value;
    }
  }
  return string
}

function saveDrawing(){
  console.log("SPRITE SAVED")
  var path = "http://localhost:4567/save" + captureDrawing();
  xHR.open("get",path);
  xHR.send()
  window.location.href = "http://localhost:4567/";
}

function loadDrawing(){
  var path = "http://localhost:4567/load/" + dropdown.value;
  xHR.open("get",path);
  xHR.send();
  xHR.addEventListener("load", drawDrawing);
}

function drawDrawing(){
  var sprite = JSON.parse(this.response)
  for (y = 0; y < rowsArray.length; y ++){
    for (x = 0; x < rowsArray[y].children.length; x++){
      var cellId = "x" + String(x) + "y" + String(y);
      document.getElementById(cellId).style.background = palette[Number(sprite[cellId])]
    }
  };
}