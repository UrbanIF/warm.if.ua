module.exports = (x)->

  $listContainer = $('.map ul.list')
  groups = [
    {
      title: 'Магазини',
      color: '#ff2f13',
      markers: [{
        icon: 'assets/markers/icon1.png',
        title: 'Говорить Івано-Франківськ',
        address: 'пл. Ринок, 8, Івано-Франківськ',
        coords: {
          lat: 48.92191,
          lng: 24.71005
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Мануфактура',
        address: 'пл. Міцкевича, 6, Івано-Франківськ',
        coords: {
          lat: 	48.920961,
          lng: 	24.711749999999938
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Сувенірний штаб',
        address: 'вул. Незалежності, 18/2, Івано-Франківськ',
        coords: {
          lat: 	48.91905,
          lng: 	24.71247500000004
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Fabbrica',
        address: 'вул. Вірменська, 1, Івано-Франківськ',
        coords: {
          lat: 	48.922224,
          lng: 	24.711207999999942
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Аватар',
        address: 'вул. Мельника, 2, Івано-Франківськ',
        coords: {
          lat: 	48.91871339999999,
          lng: 	24.714699999999993
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Оле-Тур',
        address: 'вул. Січових Стрільців, 19, Івано-Франківськ',
        coords: {
          lat: 	48.919142,
          lng: 	24.709946299999956
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Ейнштейн',
        address: 'пл. Ринок, 1, Івано-Франківськ',
        coords: {
          lat: 	48.9232953,
          lng: 	24.71026900000004
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Дон Педро',
        address: 'вул. І.Франка, 27, Івано-Франківськ',
        coords: {
          lat: 	48.92286319999999,
          lng: 		24.71660129999998
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Chicken Hut',
        address: 'вул. Бельведерська, 21А, Івано-Франківськ',
        coords: {
          lat: 	48.9227353,
          lng: 	24.704589599999963
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Ваш партнер',
        address: 'вул. Грушевського, 1, Івано-Франківськ',
        coords: {
          lat: 	48.92066699999999,
          lng: 	24.71003500000006
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Магазин "Для тебе"',
        address: 'вул. Незалежності, 40, Івано-Франківськ',
        coords: {
          lat: 	48.91767530000001,
          lng: 	24.717138100000057
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Гриль-ресторан "Вулик"',
        address: 'вул. Пасічна, 43, Івано-Франківськ',
        coords: {
          lat: 	48.9380743,
          lng: 	24.693299199999956
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Плюс',
        address: 'вул. Тролейбусна, 1, Івано-Франківськ',
        coords: {
          lat: 	48.944353,
          lng: 	24.69907569999998
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: 'Плюс',
        address: 'вул. Симоненка, 15, Івано-Франківськ',
        coords: {
          lat: 	48.9400922,
          lng: 	24.747392999999988
        }
      },{
        icon: 'assets/markers/icon1.png',
        title: '12 персон',
        address: 'Бастіон, Фортечний провулок, 1, Івано-Франківськ',
        coords: {
          lat: 	48.9225222,
          lng: 	24.707551800000033
        }
      }]
    },
    {
      title: 'Офіс "Тепле місто"',
      color: '#aaaf13',
      markers: [{
        icon: 'assets/markers/office.png',
        title: 'marker1',
        address: 'вул. Тринітарська 11, офіс 9, Івано-Франківськ',
        coords: {
          lat: 48.9236908,
          lng: 	24.71116189999998
        }
      }]
    },
    {
      title: 'UrbanSpace 100',
      color: '#002f13',
      markers: [{
        icon: 'assets/markers/urban.png',
        title: 'UrbanSpace 100',
        address: 'вул. Грушевського, 19, Івано-Франківськ',
        coords: {
          lat: 48.9213233,
          lng: 24.713921099999993
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
