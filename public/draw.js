function boot(){
  palette = ["rgb(212, 235, 138)","rgb(153, 181, 102)","rgb(95, 128, 67)","rgb(26, 61, 24)","rgba(255, 0, 255, 0)"];
  xHR = new XMLHttpRequest();/Users/andrewyolland/Desktop/KirbyTileset.gif
  highSwatch = document.getElementById("highlight");
  midSwatch = document.getElementById("midtone");
  shadSwatch = document.getElementById("shadow");
  swatchesArray = document.getElementById("palette").children;
  rowsArray = document.getElementById("grid").children;
  saveButton = document.getElementById("save_button");
  nameField = document.getElementById("name_field");
  dropdown = document.getElementById("dropdown");
  loadButton = document.getElementById("load_button");
  clearButton = document.getElementById("clear_button");
  deleteButton = document.getElementById("delete_button");
  editButton = document.getElementById("edit_button");
  userId = document.getElementById("user_id").value;
  spriteId = document.getElementById("viewing_sprite_id");
  spriteName = document.getElementById("viewing_sprite_name");

  // highSwatch.addEventListener("click",setPointer);
  // midSwatch.addEventListener("click",setPointer);
  // shadSwatch.addEventListener("click",setPointer);
  loadButton.addEventListener("click",function(){location.href = "/view_sprite/" + dropdown.value});
  clearButton.addEventListener("click",clearPixels);
  
  if (saveButton != null) {
    saveButton.addEventListener("click",function(){saveDrawing(event)});
  };
  
  if (deleteButton != null) {
    deleteButton.addEventListener("click",deleteDrawing);
    editButton.addEventListener("click",editDrawing);
  };
  
  for (y = 0; y < rowsArray.length; y ++){
    for (x = 0; x < rowsArray[y].children.length; x++){
      rowsArray[y].children[x].addEventListener("click",setPixel);
    }
  };
  
  for (i = 0; i < swatchesArray.length; i ++){
    swatchesArray[i].addEventListener("click",setPointer);
  };
  
  setSwatches();
  if (!spriteId){
    clearPixels();
  };
  
  pointerColor = palette[1]
  if (spriteId != null){
    loadDrawing(spriteId.value)
  }
}

window.onload = boot;

function setSwatches(){
  // highSwatch.style.background = palette[0];
  // midSwatch.style.background = palette[1];
  // shadSwatch.style.background = palette[2];
  for (i = 0; i < swatchesArray.length; i ++){
    swatchesArray[i].style.background = palette[i];
  };
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
  var string = "name=" + nameField.value + "&user_id=" + userId;
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

function saveDrawing(event){
  event.preventDefault();
  var path = "/save?" + captureDrawing();
  xHR.open("get",path);
  xHR.send();
  xHR.addEventListener("load", newViewSprite);
}

function editDrawing(event){
  event.preventDefault() 
  var path = "/edit?id=" + spriteId.value + "&" + captureDrawing();
  xHR.open("get",path);
  xHR.send();
  xHR.addEventListener("load", newViewSprite);
}

function loadDrawing(sprite_id){
  var path = "/load/" + sprite_id;
  xHR.open("get",path);
  xHR.send();
  xHR.addEventListener("load", drawDrawing);
}

function deleteDrawing(){
  var path = "/delete/" + dropdown.value;
  xHR.open("get",path);
  xHR.send();
  setInterval(location.href = "/", 3000);
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

function newViewSprite(){
  var quickhash = JSON.parse(this.response)
  setInterval(location.href = "/view_sprite/" + quickhash.sprite_id, 3000);
};