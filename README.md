# Book of Fortresses
* https://www.bookoffortresses.org

## Populating the database:
* Records are created/maintained in [Airtable](https://airtable.com/) and loaded into the application's Postgres database using the [Airtable API](https://airtable.com/api).
* That code can be found here: lib/tasks/airtable_import.rake
* Your authorization token should be stored in a .env file; ex: AIRTABLE_TOKEN = "Bearer key"
* To load the records:
  * rake db:load_collaborators
  * rake db:load_locations
  * rake db:load_images

## OpenSeadragon:
* To work with the asset pipeline, openseadragon.js was modified.
  * find the file here: vendor/assets/openseadragon/openseadragon.js.erb
  * openseadragon.js --> openseadragon.js.erb
  * Replace:
    `//INTERFACE RESOURCE SETTINGS
    prefixUrl: "/images/",
    navImages: {
        zoomIn: {
            REST:   'zoomin_rest.png',
            GROUP:  'zoomin_grouphover.png',
            HOVER:  'zoomin_hover.png',
            DOWN:   'zoomin_pressed.png'
        },
        zoomOut: {
            REST:   'zoomout_rest.png',
            GROUP:  'zoomout_grouphover.png',
            HOVER:  'zoomout_hover.png',
            DOWN:   'zoomout_pressed.png'
        },
        home: {
            REST:   'home_rest.png',
            GROUP:  'home_grouphover.png',
            HOVER:  'home_hover.png',
            DOWN:   'home_pressed.png'
        },
        fullpage: {
            REST:   'fullpage_rest.png',
            GROUP:  'fullpage_grouphover.png',
            HOVER:  'fullpage_hover.png',
            DOWN:   'fullpage_pressed.png'
        },
        rotateleft: {
            REST:   'rotateleft_rest.png',
            GROUP:  'rotateleft_grouphover.png',
            HOVER:  'rotateleft_hover.png',
            DOWN:   'rotateleft_pressed.png'
        },
        rotateright: {
            REST:   'rotateright_rest.png',
            GROUP:  'rotateright_grouphover.png',
            HOVER:  'rotateright_hover.png',
            DOWN:   'rotateright_pressed.png'
        },
        previous: {
            REST:   'previous_rest.png',
            GROUP:  'previous_grouphover.png',
            HOVER:  'previous_hover.png',
            DOWN:   'previous_pressed.png'
        },
        next: {
            REST:   'next_rest.png',
            GROUP:  'next_grouphover.png',
            HOVER:  'next_hover.png',
            DOWN:   'next_pressed.png'
        }
    },`

    with:

    `//INTERFACE RESOURCE SETTINGS

    prefixUrl:  "",
    navImages: {
      zoomIn: {
      REST:     '<%= asset_path 'openseadragon/zoomin_rest.png' %>',
      GROUP:    '<%= asset_path 'openseadragon/zoomin_grouphover.png' %>',
      HOVER:    '<%= asset_path 'openseadragon/zoomin_hover.png' %>',
      DOWN:     '<%= asset_path 'openseadragon/zoomin_pressed.png' %>'
    },
    zoomOut: {
        REST:   '<%= asset_path 'openseadragon/zoomout_rest.png' %>',
        GROUP:  '<%= asset_path 'openseadragon/zoomout_grouphover.png' %>',
        HOVER:  '<%= asset_path 'openseadragon/zoomout_hover.png' %>',
        DOWN:   '<%= asset_path 'openseadragon/zoomout_pressed.png' %>'
    },
    home: {
        REST:   '<%= asset_path 'openseadragon/home_rest.png' %>',
        GROUP:  '<%= asset_path 'openseadragon/home_grouphover.png' %>',
        HOVER:  '<%= asset_path 'openseadragon/home_hover.png' %>',
        DOWN:   '<%= asset_path 'openseadragon/home_pressed.png' %>'
    },
    fullpage: {
        REST:   '<%= asset_path 'openseadragon/fullpage_rest.png' %>',
        GROUP:  '<%= asset_path 'openseadragon/fullpage_grouphover.png' %>',
        HOVER:  '<%= asset_path 'openseadragon/fullpage_hover.png' %>',
        DOWN:   '<%= asset_path 'openseadragon/fullpage_pressed.png' %>'
    },
    rotateleft: {
        REST:   '<%= asset_path 'openseadragon/rotateleft_rest.png' %>',
        GROUP:  '<%= asset_path 'openseadragon/rotateleft_grouphover.png' %>',
        HOVER:  '<%= asset_path 'openseadragon/rotateleft_hover.png' %>',
        DOWN:   '<%= asset_path 'openseadragon/rotateleft_pressed.png' %>'
    },
    rotateright: {
        REST:   '<%= asset_path 'openseadragon/rotateright_rest.png' %>',
        GROUP:  '<%= asset_path 'openseadragon/rotateright_grouphover.png' %>',
        HOVER:  '<%= asset_path 'openseadragon/rotateright_hover.png' %>',
        DOWN:   '<%= asset_path 'openseadragon/rotateright_pressed.png' %>'
    },
    previous: {
        REST:   '<%= asset_path 'openseadragon/previous_rest.png' %>',
        GROUP:  '<%= asset_path 'openseadragon/previous_grouphover.png' %>',
        HOVER:  '<%= asset_path 'openseadragon/previous_hover.png' %>',
        DOWN:   '<%= asset_path 'openseadragon/previous_pressed.png' %>'
    },
    next: {
        REST:   '<%= asset_path 'openseadragon/next_rest.png' %>',
        GROUP:  '<%= asset_path 'openseadragon/next_grouphover.png' %>',
        HOVER:  '<%= asset_path 'openseadragon/next_hover.png' %>',
        DOWN:   '<%= asset_path 'openseadragon/next_pressed.png' %>'
    }
  },`
