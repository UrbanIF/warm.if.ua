logger = require('./logger/logger')

logger('hello browserify!!')


initialize = ->
  mapCanvas = document.getElementById("map-container")
  mapOptions =
    center: new google.maps.LatLng(44.5403, -78.5463)
    zoom: 8
    scrollwheel: false
    mapTypeId: google.maps.MapTypeId.ROADMAP
    disableDefaultUI: true



  map = new google.maps.Map(mapCanvas, mapOptions)

google.maps.event.addDomListener window, "load", initialize
