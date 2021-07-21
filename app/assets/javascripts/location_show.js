// Start Paloma whenever page is loaded (including navigation events)
document.addEventListener("turbolinks:load", function() {
  Paloma.start();
})

Paloma.controller('Locations', {
  show: function(){

    var images = this.params.images;
    // var plan_url = this.params.plan_url;

    // set variables
    var model = document.getElementById('3d_model');
    // var plan_drawing = document.getElementById('location_plan');

    // show or hide elements
    function hide(e){
      e.style.display = "none";
    }

    function show(e){
      e.style.display = '';
    }

    // function make_invisible(e){
    //   e.style.visibility = "hidden";
    // }
    //
    // function make_visible(e){
    //   e.style.visibility = '';
    // }

    // Set viewer size
    function size_viewer(e){
      e.style.width = "100%";
      e.style.height = "100%";
    }

    // Determine initial viewer model/image
    function startup(){

      // if the location has a 3D model, display that in the viewer space
      // if (model) {
      //   load_model();
      // }

      // if the location does not have a 3D model, display the image for the first image card in the viewer
      // else {
        id = 'openseadragon_image_left_' + images[0].id
        console.log(id)
        show(document.getElementById(id));

        id = 'openseadragon_image_right_' + images[0].id
        console.log(id)
        show(document.getElementById(id));
      // }
    }

    // Add onclick event listeners to cards and buttons
    function add_listeners(){

      // plan_drawing.addEventListener('click', load_plan);
      // agol_button.addEventListener('click', display_agol_slide);
      // image_button.addEventListener('click', reload_image);
    }

    function hide_all(){
      // Hide all viewer divs
      [].forEach.call(document.querySelectorAll('.openseadragon'), function (viewerWindow) {
        hide(viewerWindow);
      });
    }

    function load_image(){
      hide_all();

      // un-hide corresponding viewer div
      show(document.getElementById('openseadragon_'+this.id));

    }

    function load_model(){
      hide_all();

      // un-hide viewer div for 3D model
      var model_viewer = document.getElementById('3d_model_iframe');
      show(model_viewer);

      // select and style 3D model iframe
      size_viewer(model_viewer.getElementsByTagName("iframe")[0]);

    }

    // function load_plan(){
    //   hide_all();
    //
    //   // select & un-hide plan viewer div
    //   show(document.getElementById('openseadragon_plan'));
    // }

      function display_agol_slide() {

        // un-hide agol viewer
        // var agol_embed = document.getElementById('agol_slide_'+this.id);
        // show(agol_embed);

        // style agol iframe
        // size_viewer(agol_embed.getElementsByTagName("iframe")[0]);

        // hide image openseadragon
        // hide(document.getElementById('openseadragon_'+this.id));
      }

      function reload_image(){
        hide_all();

        // unhide image viewer
        show(document.getElementById('openseadragon_'+this.id));
      }

      // viewer for plan

      // var viewer = OpenSeadragon({
      //   id: "openseadragon_plan",
      //   tileSources: {
      //     type: 'image',
      //     url: plan_url
      //   }
      // });

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

        if (image.agol_slide_embed) {
          var viewer = OpenSeadragon({
                    id: "openseadragon_image_left_" + image.id + "_landscape",
                    tileSources: {
                      type: 'image',
                      url: image.url
                    }
          });

          var viewer = OpenSeadragon({
                    id: "openseadragon_image_right_" + image.id + "_landscape",
                    tileSources: {
                      type: 'image',
                      url: image.url
                    }
          });
        }
      }

//       function myFunction(item, index) {
//   text += index + ": " + item + "<br>";
// }

      // for (var i = 0; i < images.length; i++) {
      //   var viewer = OpenSeadragon({
      //             id: "openseadragon_image_"+i,
      //             tileSources: {
      //               type: 'image',
      //               url: images[i].url
      //             }
      //   });
      // }

      startup();
      add_listeners();

  }
});

function hide(e){
  e.style.display = "none";
}
function show(e){
  e.style.display = '';
}


function hide_all(){
  // Hide all viewer divs
  [].forEach.call(document.querySelectorAll('.openseadragon'), function (viewerWindow) {
    hide(viewerWindow);
  });
}

function size_viewer(e){
  e.style.width = "100%";
  e.style.height = "100%";
}

function changeLeftView() {
  console.log("Left View changed!!")
  hide_all();
  x = document.getElementById("views1").value;
  console.log("x: "+x)

  selected_image = document.getElementById('openseadragon_image_left_'+x)
  // var agol_embed = document.getElementById('agol_slide_'+this.id);
  // show(agol_embed);
  show(selected_image);

  // style agol iframe
  size_viewer(selected_image.getElementsByTagName("iframe")[0]);

  // show(document.getElementById('openseadragon_image_'+x));
}

function changeRightView() {
  console.log("Right View changed!!")
  hide_all();
  x = document.getElementById("views2").value;
  console.log("x: "+x)
  // show(document.getElementById('openseadragon_image_'+x));
  show(document.getElementById('openseadragon_image_right_'+x));
}
