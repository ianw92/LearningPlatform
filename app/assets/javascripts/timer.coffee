# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).on 'turbolinks:load', ->
  $('[data-toggle="popover"]').popover({
    html:true
    trigger:'click'
    });

  if localStorage.getItem("time_left") is null
    localStorage.setItem("time_left", 1500)
  if localStorage.getItem("timer_running") is null
    localStorage.setItem("timer_running", false)

  window.timer = setInterval( ->
    # console.log("timer running : #{localStorage.getItem("timer_running")}")
    time_left = localStorage.getItem("time_left")
    if localStorage.getItem("timer_running") is "true"

      time_left -= 1
      localStorage.setItem("time_left", time_left)
      localStorage.setItem("last_interval_stopped", false)

      # console.log("time left #{time_left}")

    minutes = Math.floor((time_left / 60))
    seconds = Math.floor((time_left % 60))

    # // Display the result in the element with id="timer"
    $('#timer').html("#{minutes}:#{seconds}")

    if time_left is 0
      localStorage.setItem("timer_running", false)
      localStorage.setItem("time_left", 1500)
      alert("Time up!")

  , 1000)

$(document).on 'turbolinks:click', ->
  clearInterval(window.timer)
  # console.log("before unload event")
