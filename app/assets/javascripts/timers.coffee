# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



$(document).on 'turbolinks:load', ->
  $('[data-toggle="popover"]').popover({
    html:true
    trigger:'click'
    });

  study_timer_time = $('#study_timer_input').val()*60
  short_break_time = $('#short_break_input').val()*60
  long_break_time = $('#long_break_input').val()*60

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

    minutes = ("0" + Math.floor((time_left / 60))).slice(-2);
    seconds = ("0" + Math.floor((time_left % 60))).slice(-2);

    # // Display the result in the element with id="timer"
    $('#timer').html("#{minutes}:#{seconds}")

    if time_left is 0
      localStorage.setItem("timer_running", false)
      localStorage.setItem("time_left", 1500)
      alert("Time up! Do you need a break? Have a drink of water and go for a brief walk!")

  , 1000)

  # Timer Controls
  $('#start-btn').click( ->
    localStorage.setItem("timer_running", true))

  $('#stop-btn').click( ->
    localStorage.setItem("timer_running", false))

  $('#reset-btn').click( ->
    localStorage.setItem("time_left", study_timer_time)
    $('#timer').html("#{study_timer_time/60}:00")
    )

  # Timer Settings
  $('#study-timer-btn').click( ->
    localStorage.setItem("time_left", study_timer_time))

  $('#short-break-btn').click( ->
    localStorage.setItem("time_left", short_break_time))

  $('#long-break-btn').click( ->
    localStorage.setItem("time_left", long_break_time))

  $('#save-timer-settings').click( ->

    study_timer_time = $('#study_timer_input').val()*60
    short_break_time = $('#short_break_input').val()*60
    long_break_time = $('#long_break_input').val()*60
    alert("Timer settings successfully saved")
    )


$(document).on 'turbolinks:click', ->
  clearInterval(window.timer)
