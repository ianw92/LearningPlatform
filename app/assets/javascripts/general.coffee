$(document).on 'turbolinks:load', ->
  # Fade out notices after 5 seconds
  setTimeout( ->
    $('.notice').fadeOut('slow')
  , 5000
  )
  # Fade out alerts after 5 seconds
  setTimeout( ->
    $('.alert').fadeOut('slow')
  , 5000
  )
