module.exports = (x)->

  $listContainer = $('.map ul.list')
  groups = [
    {
      title: 'Арт',
      color: '#ff2f13',
      markers: [{
        icon: 'assets/markers/icon1.png',
        title: 'marker1',
        address: 'вул. Л.Курбаса 5, Івано-Франківськ',
        coords: {
          lat: 48.92143799999999,
          lng: 24.712647400000037
        }
      }]
    },
    {
      title: 'Проведені події',
      color: '#aaaf13',
      markers: [{
        icon: 'assets/markers/icon4.png',
        title: 'marker1',
        address: 'вул. Галицька 65, Івано-Франківськ',
        coords: {
          lat: 48.9287565,
          lng: 24.7092137
        }
      },{
        icon: 'assets/markers/icon4.png',
        title: 'marker1',
        address: 'вул. Коновальця 25, Івано-Франківськ',
        coords: {
          lat: 48.9170916,
          lng: 24.711238
        },
      }]
    },
    {
      title: 'Реконструкція',
      color: '#002f13',
      markers: [{
        icon: 'assets/markers/icon3.png',
        title: 'marker1',
        address: 'вул. Незалежносні 12, Івано-Франківськ',
        coords: {
          lat: 48.9199346,
          lng: 24.709554600000047
        }
      }]
    }
  ]
  placeMarkers = (markerGroups, map)->
    geocoder = new google.maps.Geocoder()
    for group in markerGroups
      group.markerObjs = []
      for marker in group.markers
        marker = new google.maps.Marker(
          map: map
          position: marker.coords
          icon: marker.icon
        )
        group.markerObjs.push(marker)

  showAllMarkers = (markerGroups, show=true )->
    for group in markerGroups
      for marker in group.markerObjs
        marker.setVisible(show)

  buildList = (markerGroups)->
    $listContainer.find('.item').remove()
    for group, n in markerGroups
      li = $('<li>').addClass('item')
      li.text(group.title)
      li.prepend($('<i>').css('background', group.color))
      li.data('group', n)
      $listContainer.append(li)

  showGroup = (groups, groupId)->
    for marker in groups[groupId].markerObjs
      marker.setVisible(true)

  groupSelectedEvent = (e)->
    item = $(e.target)
    $listContainer.find('li').removeClass('active')
    item.addClass('active')
    showAllMarkers(groups, false)
    showGroup(groups, item.data('group'))

  showAllSelectedEvent = (e)->
    item = $(e.target)
    $listContainer.find('li').removeClass('active')
    item.addClass('active')
    showAllMarkers(groups, true)

  initEvents = ->
    $listContainer.on 'click', 'li.item', groupSelectedEvent
    $listContainer.on 'click', 'li.all', showAllSelectedEvent

  initialize = ->
    mapCanvas = document.getElementById("map-container")
    mapOptions =
      center: new google.maps.LatLng(48.92143799999999, 24.712647400000037)
      zoom: 14
      scrollwheel: false
      mapTypeId: google.maps.MapTypeId.ROADMAP
      disableDefaultUI: true
    map = new google.maps.Map(mapCanvas, mapOptions)
    buildList(groups)
    placeMarkers(groups, map)
    initEvents()

  google.maps.event.addDomListener window, "load", initialize