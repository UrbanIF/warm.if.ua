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
  $window = $(window)
  $element = $(".paralax")
  iframe = $('#player')[0]
  width = $('.filled').data('width')
  $('.filled').width(width)

  $('li .content.white a, section.partners .list img, span.help').tooltipster(
    contentAsHTML: true
    theme: 'tooltipster-warm'
    interactive: true
  )

  if $element.length > 0
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

  dialog = do ->
    $videoOverlay = $('.video-overlay')
    $dialogOverlay = $('.dialog-overlay')
    $supportButton = $('.support-button')
    $allSteps = $('.steps')
    $defaultStep = $('.step1')
    $humanStep = $('.step2')
    $companyStep = $('.step2c')
    $moneyStep = $('.money-help')
    $successStep = $('.success-step')
    $businessFormStep = $('.form-business')
    $peopleFormStep = $('.form-people')
    $backButton = $('.back')

    $currentStep = $defaultStep

    previousSteps = []

    showOverlay = ($container)->
      $container.addClass('visible')
      $('html').addClass('with-overlay')
    hideOverlay = ($container)->
      $container.removeClass('visible')
      $('html').removeClass('with-overlay')

    $('.how-it-works-link'). on 'click', (e)->
      player = $f(iframe)
      e.preventDefault()
      showOverlay($videoOverlay)
      player.api('play')

    $videoOverlay.on 'click', ->
      player = $f(iframe)
      player.api('pause')
      hideOverlay($videoOverlay)

    $supportButton. on 'click', (e)->
      e.preventDefault()
      showFirstStep()
      showOverlay($dialogOverlay)

    $('.dialog-overlay .close, .dialog-overlay .close-link'). on 'click', (e)->
      e.preventDefault()
      hideOverlay($dialogOverlay)

    checkBackButton = ->
      $backButton.show() if previousSteps.length > 0
      $backButton.hide() if previousSteps.length is 0

    transitToStep = ($nextStep) ->
      $currentStep.fadeOut 'fast', ->
        $nextStep.fadeIn 'fast'
      previousSteps.push $currentStep
      checkBackButton()
      $currentStep = $nextStep

    backStep = ->
      $previous = previousSteps.pop()
      if $previous
        $currentStep.fadeOut 'fast', ->
          $previous.fadeIn 'fast'
        checkBackButton()
        $currentStep = $previous

    showSuccessStep = (e)->
      e.preventDefault()
      transitToStep($successStep)
      previousSteps = []
      checkBackButton()

    showHumanStep = (e)->
      e.preventDefault()
      transitToStep($humanStep)

    showCompanyStep = (e)->
      e.preventDefault()
      transitToStep($companyStep)

    showBusinessFormStep= (e)->
      e.preventDefault()
      transitToStep($businessFormStep)

    showPeopleFormStep= (e)->
      e.preventDefault()
      transitToStep($peopleFormStep)

    showMoneyStep= (e)->
      e.preventDefault()
      transitToStep($moneyStep)

    showFirstStep = ->
      $allSteps.hide()
      $defaultStep.show()
      $currentStep = $defaultStep

    showOverlayWithForm= (e)->
      showOverlay($dialogOverlay)
      showBusinessFormStep(e)

    checkBackButton()
    $('.step1 .as-human').on 'click', showHumanStep
    $('.step1 .as-company').on 'click', showCompanyStep
    $('.step2c .become-business-partner').on 'click', showBusinessFormStep
    $('.step2 .become-member').on 'click', showPeopleFormStep
    $('form.business').on 'submit', showSuccessStep
    $('form.people').on 'submit', showSuccessStep
    $('.give-money').on 'click', showMoneyStep

    $('.sign-as-company').on 'click', showOverlayWithForm

    $('.back').on 'click', backStep

    $('.project'). on 'click', ->
      href = $(@).data('href')
      window.open(href) unless href is undefined


  # pos-scrolled
