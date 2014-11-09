require('./map')()
parallax = require('./parallax')
popups = require('./popups')

$ ->

  # make color logo for company
  $('.companies .content.white img').on
    'mouseenter': ->
      img = $(@)
      src = img.prop 'src'
      img.prop 'src', img.data('hover')
      img.data 'src', src
    'mouseleave': ->
      img = $(@)
      img.prop 'src', img.data('src')

  # progress bar
  width = $('.filled').data('width')
  $('.filled').width(width)


  $('li .content.white a, section.partners .list img, span.help').tooltipster(
    contentAsHTML: true
    theme: 'tooltipster-warm'
    interactive: true
  )

  parallax()

  popups()
