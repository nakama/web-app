{CollectionView, log, mediator} = require 'common'
itemView         = require 'views/photo_collection_item_view'
template         = require 'views/templates/photo_collection'
Photo                       = require 'models/photo'

module.exports = class PhotoCollectionView extends CollectionView
  template: template
  container: '#master-container'
  autoRender: true
  itemView: itemView
  listSelector: '#photos-list'
  id: "photo-collection-wrapper"

  #events:
    #'hover .photo-wrapper': 'hoverInWrapper'
    #'mouseout .photo-wrapper': 'hoverOutWrapper'

  initialize: ->
    super
    log 'initializing the Photo Collection View'

    #@subscribeEvent 'api:photos:fetched', @onFetched
    @subscribeEvent 'grid:reset', @gridReset
    @subscribeEvent 'grid:toggle', @gridToggle

    ###
    @modelBind 'change', ->
      log "PhotoCollection View change",
          model: if @model then @model else null
          collection: if @collection then @collection else null

      @render
      @renderAllItems
    ###
    @collection.on 'add', ->
      log "PhotoCollectionView item added",
        arguments: arguments

  hoverInWrapper: (e) ->
    e.preventDefault()

    if e.target.tagName is "IMG"
      $container = $(e.target).parent()
      $footer    = $container.parent().find('footer')
      $height    = $container.height()

      $container.animate({
        height: '280px'
      }, { duration: 200, queue: false } )

      $footer.animate({
        height: '100px'
      }, { duration: 200, queue: false } )

  hoverOutWrapper: (e) ->
    e.preventDefault()

    if e.target.tagName is "IMG"
      $container = $(e.target).parent()
      $footer    = $container.parent().find('footer')
      $height    = $container.height()

      $container.animate({
        height: '320px'
      }, { duration: 200, queue: false } )

      $footer.animate({
        height: '60px'
      }, { duration: 200, queue: false } )

  gridReset: ->
    $photoList = $("#photos-list")
    isotopeConfig =
      itemSelector: ".photo-wrapper"
      layoutMode: 'fitRows'
      ###
      layoutMode: "cellsByRow"
      cellsByRow:
        columnWidth: 260
        rowHeight: 390
      ###

    $photoList.imagesLoaded ->
      log "Photos loaded"
      $photoList.isotope isotopeConfig
      
      #Tell isotope what data can be sorted
      $photoList.isotope getSortData:
        stars: ($elem) ->
          $elem.find("[data-stars]").text()

      ###
      $('#photos-list .photo-wrapper').hover ( (e) ->
        e.preventDefault()

        $container = $(this).find('.photo-container')
        $footer    = $(this).find('footer')
        $height    = $container.height()

        $container.animate({
          height: '280px'
        }, { duration: 200, queue: false } )

        $footer.animate({
          height: '100px'
        }, { duration: 200, queue: false } )

      ), (e) ->
        e.preventDefault()

        $container = $(this).find('.photo-container')
        $footer    = $(this).find('footer')
        $height    = $container.height()

        $container.animate({
          height: '320px'
        }, { duration: 200, queue: false } )

        $footer.animate({
          height: '60px'
        }, { duration: 200, queue: false } )
      ###

  gridToggle: (e) ->
    #not sure what to do yet
    @gridReset()

  renderAllItems: ->
    super
    #console.log 'collection rendered'

    @gridReset()

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