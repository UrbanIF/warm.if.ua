module.exports = (x)->
  iframe = $('#player')[0]

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

  $supportButton.on 'click', (e)->
    e.preventDefault()
    console.log $(@).prop('href')
    location.href = $(@).prop('href')
  # showFirstStep()
  # showOverlay($dialogOverlay)


  $('.dialog-overlay .close, .dialog-overlay .close-link'). on 'click', (e)->
    e.preventDefault()
    hideOverlay($dialogOverlay)

  checkBackButton = ->
    $backButton.show() if previousSteps.length > 0
    $backButton.hide() if previousSteps.length is 0 or location.hash is '#step1'

  transitToStep = ($nextStep) ->
    console.log $('.dialog-overlay').css('opacity') is '0'
    showOverlay($dialogOverlay) if $('.dialog-overlay').css('opacity') is '0'
    $currentStep.fadeOut 'fast', ->
      $nextStep.fadeIn 'fast'
    previousSteps.push $currentStep
    checkBackButton()
    $currentStep = $nextStep

  backStep = ->
    $previous = previousSteps.pop()
    if $previous
      # $currentStep.fadeOut 'fast', ->
      #   $previous.fadeIn 'fast'
      window.history.back()
      checkBackButton()
  # $currentStep = $previous


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
    previousSteps = []
    e.preventDefault()
    location.hash = 'step2c'

    showOverlay($dialogOverlay)
    showCompanyStep(e)


  checkBackButton()
  # $('.step1 .as-human').on 'click', showHumanStep
  # $('.step1 .as-company').on 'click', showCompanyStep
  # $('.step2c .become-business-partner').on 'click', showBusinessFormStep
  # $('.step2 .become-member').on 'click', showPeopleFormStep
  # $('form.business').on 'submit', showSuccessStep
  # $('form.people').on 'submit', showSuccessStep
  # $('.give-money').on 'click', showMoneyStep

  $('.sign-as-company').on 'click', showOverlayWithForm

  $('.back').on 'click', backStep

  skipSteps = ['#projects','#info', '']

  initHashchangeEvent = (->
    $(window).on 'hashchange', (e)->

      if location.hash not in skipSteps
        console.log 'hash changed'
        transitToStep($(location.hash))
      else
        hideOverlay($dialogOverlay)
  )()

  preloadImages = (->
    $('.companies a img').each ->
      ob = $(@)
      if ob.data('hover')
        i =  new Image()
        i.src = ob.data('hover')
  )()

