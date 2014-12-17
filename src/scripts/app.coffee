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


  $('li .content.white a, span.help').tooltipster(
    contentAsHTML: true
    theme: 'tooltipster-warm'
    interactive: true
  )

  parallax()

  popups()

  # highlight active menu item
  path = window.location.pathname
  $("a[href='#{path}']").addClass('active')

  # external links in new window
  $("a[href^='http://'], a[href^='https://']").attr("target","_blank")
  
  stLight.options
    publisher: "75111b81-2647-4c71-9361-92cfc4839401"
    doNotHash: true
    doNotCopy: true
    hashAddressBar: true
