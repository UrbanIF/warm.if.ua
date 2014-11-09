module.exports = (x)->

  $window = $(window)
  $element = $(".paralax")

  newPos = ( windowHeight, pos, adjuster, inertia) ->
    (((windowHeight + pos) + adjuster) * inertia) + "px"

  if $element.length > 0
    elementPos = $element.offset().top

    $window.on 'scroll', (e)->
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