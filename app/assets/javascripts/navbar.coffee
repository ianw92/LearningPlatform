add_remove_timer_align = ->
  if window.matchMedia("(min-width: 768px)").matches
    $('#nav_timer_list').toggleClass("align-items-center", true)
    $('#nav_timer_list').toggleClass("collapsed-timer", false)
    $('#timer_buttons').toggleClass("collapsed-timer-buttons", false)
  else
    $('#nav_timer_list').toggleClass("align-items-center", false)
    $('#nav_timer_list').toggleClass("collapsed-timer", true)
    $('#timer_buttons').toggleClass("collapsed-timer-buttons", true)



$(document).on 'turbolinks:load', ->
  add_remove_timer_align()

$(window).resize ->
  add_remove_timer_align()
