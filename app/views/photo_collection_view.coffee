CollectionView = require 'views/base/collection_view'
itemView       = require 'views/photo_collection_item_view'
template       = require 'views/templates/photo_collection'

module.exports = class PhotoCollectionView extends CollectionView
  template: template
  container: '#master-container'
  autoRender: true
  itemView: itemView
  listSelector: '#photos-list'
  id: "photo-collection-wrapper"

  initialize: (data) ->
    super
    console.log("Initializing the PhotoCollectionView");
    #@wrapMethod('renderAllItems')

    ###
    rendered = no
    @modelBind 'change', =>
      @render() unless rendered
      rendered = yes
    ###

  afterRender: ->
    super

    console.log "How many times am I rendering?"

  renderAllItems: ->
    super
    console.log 'collection rendered'

    $photoList = $("#photos-list")
    isotopeConfig =
      itemSelector: ".photo-wrapper"
      layoutMode: "cellsByRow"
      cellsByRow:
        columnWidth: 260
        rowHeight: 400

    $photoList.imagesLoaded ->
      console.log "Photos loaded", @
      $photoList.isotope isotopeConfig
      
      #Tell isotope what data can be sorted
      $photoList.isotope getSortData:
        stars: ($elem) ->
          $elem.find("[data-stars]").text()

    ###
    navButtons = {
      stars: {
        els: $('#navigation .btn'),
        pressed: [],
        pressedCount: 0,

        1: {}
      }
    }

    filters = {};
    filters.stars = (values) ->
      filter = '';

      _.each values, (value, key) ->
        if(key > 0)
          filter = filter + ', '

        filter = filter + '[data-stars=' + value + ']'

      $photoList.isotope({ filter: filter });

    #Top navigation - Clicking on stars
    $('#filter-star-container').on 'click', '.btn', (e) ->
      e.preventDefault();

      id    = $(@).attr('id')
      value = id.substr(id.length - 1)

      #If button has not been pressed
      if _.indexOf(navButtons.stars.pressed, value) == -1
        #navButtons.stars.els.removeClass('active');
        $(@).addClass('active');
        navButtons.stars.pressed.push(value);
        navButtons.stars.pressedCount += 1;
        filters.stars(navButtons.stars.pressed);
      
      #If button has been pressed
      else
        $(@).removeClass('active');
        navButtons.stars.pressedCount -= 1;
        navButtons.stars.pressed.splice(navButtons.stars.pressed.indexOf(value),1); #Remove value from pressed array

        if navButtons.stars.pressedCount == 0
          $photoList.isotope({ filter: isotopeConfig.itemSelector });
          navButtons.stars.pressed = null;

        else
          filters.stars(navButtons.stars.pressed);

    #Photo - Colors
    setPhotoColor = ($photo, color) ->
      $photoWrapper = $photo.parents('.photo-wrapper');

      if $photo.hasClass('active')
        $photo.removeClass('active');
        $photoWrapper.attr('data-color-' + color, 0);
      
      else
        $photo.addClass('active');
        $photoWrapper.attr('data-color-' + color, 1);

    $('.photo-colors').on 'click', 'a', (e) ->
      e.preventDefault()

      if $(@).hasClass('photo-color-red')
        setPhotoColor($(@), 'red')

      if $(@).hasClass('photo-color-orange')
        setPhotoColor($(@), 'orange')

      if $(@).hasClass('photo-color-yellow')
        setPhotoColor($(@), 'yellow')

      if $(@).hasClass('photo-color-green')
        setPhotoColor($(@), 'green');

      if $(@).hasClass('photo-color-blue')
        setPhotoColor($(@), 'blue')

      if $(@).hasClass('photo-color-purple')
        setPhotoColor($(@), 'purple')

    #Photo - Stars dropup
    $('.num-stars-container').on 'click', 'a', (e) ->
      e.preventDefault();

      $photoWrapper = $(@).parents('.photo-wrapper')
      value         = $(@).html();

      #Updates the star count in the dropup display
      $photoWrapper.find('.num-stars').html(value);

      #Update the star count on the photo's html data attribute
      $photoWrapper.attr('data-stars', value);

      #Check to see if isotope filter needs to be run again to reflect photo star value change
      if navButtons.stars.pressed != null
        filters.stars(navButtons.stars.pressed);

    #Sidebar - star sorting
    $("#sort-stars-highest").on 'click', ->
      $photoList.isotope({ sortBy: 'stars', sortAscending : false });

    $("#sort-stars-lowest").on 'click', ->
      $photoList.isotope({ sortBy: 'stars', sortAscending : true });
    ###