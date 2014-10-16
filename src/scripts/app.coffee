logger = require('./logger/logger')

logger('hello browserify!!')

# $listContainer = $('.map ul.list')
# groups = [
#   {
#     title: 'Арт',
#     color: '#ff2f13',
#     markers: [{
#       icon: 'assets/markers/icon1.png',
#       title: 'marker1',
#       address: 'вул. Л.Курбаса 5, Івано-Франківськ',
#       coords: {
#         lat: 48.92143799999999,
#         lng: 24.712647400000037
#       }
#     }]
#   },
#   {
#     title: 'Проведені події',
#     color: '#aaaf13',
#     markers: [{
#       icon: 'assets/markers/icon4.png',
#       title: 'marker1',
#       address: 'вул. Галицька 65, Івано-Франківськ',
#       coords: {
#         lat: 48.9287565,
#         lng: 24.7092137
#       }
#       },{
#       icon: 'assets/markers/icon4.png',
#       title: 'marker1',
#       address: 'вул. Коновальця 25, Івано-Франківськ',
#       coords: {
#         lat: 48.9170916,
#         lng: 24.711238
#       },
#     }]
#   },
#   {
#     title: 'Реконструкція',
#     color: '#002f13',
#     markers: [{
#       icon: 'assets/markers/icon3.png',
#       title: 'marker1',
#       address: 'вул. Незалежносні 12, Івано-Франківськ',
#       coords: {
#         lat: 48.9199346,
#         lng: 24.709554600000047
#       }
#     }]
#   }
#   ]
# placeMarkers = (markerGroups, map)->
#   geocoder = new google.maps.Geocoder()
#   for group in markerGroups
#     group.markerObjs = []
#     for marker in group.markers
#       marker = new google.maps.Marker(
#         map: map
#         position: marker.coords
#         icon: marker.icon
#       )
#       group.markerObjs.push(marker)
#
# showAllMarkers = (markerGroups, show=true )->
#   for group in markerGroups
#     for marker in group.markerObjs
#       marker.setVisible(show)
#
# buildList = (markerGroups)->
#   $listContainer.find('.item').remove()
#   for group, n in markerGroups
#     li = $('<li>').addClass('item')
#     li.text(group.title)
#     li.prepend($('<i>').css('background', group.color))
#     li.data('group', n)
#     $listContainer.append(li)
#
# showGroup = (groups, groupId)->
#   for marker in groups[groupId].markerObjs
#     marker.setVisible(true)
#
# groupSelectedEvent = (e)->
#   item = $(e.target)
#   $listContainer.find('li').removeClass('active')
#   item.addClass('active')
#   showAllMarkers(groups, false)
#   showGroup(groups, item.data('group'))
#
# showAllSelectedEvent = (e)->
#   item = $(e.target)
#   $listContainer.find('li').removeClass('active')
#   item.addClass('active')
#   showAllMarkers(groups, true)
#
# initEvents = ->
#   $listContainer.on 'click', 'li.item', groupSelectedEvent
#   $listContainer.on 'click', 'li.all', showAllSelectedEvent
#
# initialize = ->
#   mapCanvas = document.getElementById("map-container")
#   mapOptions =
#     center: new google.maps.LatLng(48.92143799999999, 24.712647400000037)
#     zoom: 14
#     scrollwheel: false
#     mapTypeId: google.maps.MapTypeId.ROADMAP
#     disableDefaultUI: true
#   map = new google.maps.Map(mapCanvas, mapOptions)
#   buildList(groups)
#   placeMarkers(groups, map)
#   initEvents()
#
# google.maps.event.addDomListener window, "load", initialize


newPos = ( windowHeight, pos, adjuster, inertia) ->
  (((windowHeight + pos) + adjuster) * inertia) + "px"

$ ->

  $overlay = $('.overlay')
  $window = $(window)
  $element = $(".paralax")
  iframe = $('#player')[0]

  width = $('.filled').data('width')
  $('.filled').width(width)

  $('li .content.white a').tooltipster(
    contentAsHTML: true
    theme: 'tooltipster-warm'
    interactive: true
  )

  $('.how-it-works-link'). on 'click', (e)->
    player = $f(iframe)
    e.preventDefault()
    $overlay.addClass('visible')
    $('body').addClass('with-overlay')
    player.api('play')

  $overlay.on 'click', ->
    player = $f(iframe)
    player.api('pause')
    $overlay.removeClass('visible')
    $('body').removeClass('with-overlay')


  $('li .content.white a').on
    'mouseenter': ->
      img = $(@).find('img')
      src = img.prop 'src'
      img.prop 'src', img.data('hover')
      img.data 'src', src
    'mouseleave': ->
      img = $(@).find('img')
      $(@).find('img').prop 'src', img.data('src')

  elementPos = $element.offset().top

  $window. on 'scroll', (e)->
    windowHeight = $window.height()

    pos = $window.scrollTop()

    if pos >= (elementPos-windowHeight)
      $element.css visibility: 'visible'
    else
      $element.css visibility: 'hidden'
    # console.log 'pos: '+ pos
    # console.log 'elementPos: '+ elementPos
    # console.log '(elementPos-windowHeight): ' + (elementPos-windowHeight)
    $element.css
      transform: "translateY(#{newPos( windowHeight, pos, -3600, 0.5)})"


    # pos-scrolled
