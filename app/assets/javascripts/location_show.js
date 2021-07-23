var startPaloma = function() {
  Paloma.start();
};

if (
    document.readyState === "complete" ||
    (document.readyState !== "loading" && !document.documentElement.doScroll)
) {
  startPaloma();
} else {
  document.addEventListener("DOMContentLoaded", startPaloma);
}

Paloma.controller('Locations', {
  show: function(){

    var images = this.params.images;

    // set viewer size for 3D GIS
    // Set viewer size
    function size_viewer(iframe, index){
      iframe.style.width = "100%";
      iframe.style.height = "100%";
    }

    function startUp(){
      var iframes = document.getElementsByTagName("iframe");
      var iframes_array = Array.prototype.slice.call(iframes);

      iframes_array.forEach(size_viewer);
    }

    // Create openseadragon viewer for each image
    images.forEach(createViewer);
    function createViewer(image, index) {
      id = "openseadragon_image_left_" + image.id
      var viewer = OpenSeadragon({
                id: id,
                tileSources: {
                  type: 'image',
                  url: image.url
                }
      });

      id = "openseadragon_image_right_" + image.id
      var viewer = OpenSeadragon({
                id: id,
                tileSources: {
                  type: 'image',
                  url: image.url
                }
      });

    }
    startUp();
  }
});

function show_model(e) {
  e.style.height = "100%";
}

function hide(e){
  e.style.display = "none";
}

function show(e){
  e.style.display = '';
}

function hideLeftViewers() {
  var wrapper = document.getElementById('left-viewer-wrapper');
  [].forEach.call(wrapper.querySelectorAll('.openseadragon'), function (viewerWindow) {
    hide(viewerWindow);
  });
}

function reload_model(model){
  var iframe = model.getElementsByTagName('iframe')[0]
  iframe.src = iframe.src
}

function changeLeftView() {
  hideLeftViewers();

  x = document.getElementById("views1").value;
  selected_image = document.getElementById('openseadragon_image_left_'+x)
  show(selected_image);

  if (x == "3D") {
    reload_model(selected_image);
  }
}

function hideRightViewers() {
  var wrapper = document.getElementById('right-viewer-wrapper');
  [].forEach.call(wrapper.querySelectorAll('.openseadragon'), function (viewerWindow) {
    hide(viewerWindow);
  });
}

function changeRightView() {
  hideRightViewers();
  x = document.getElementById("views2").value;
  selected_image = document.getElementById('openseadragon_image_right_'+x)
  show(document.getElementById('openseadragon_image_right_'+x));
  if (x == "3D") {
    reload_model(selected_image);
  }
}
