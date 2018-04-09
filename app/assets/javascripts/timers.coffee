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

  if localStorage.getItem("timer_type") is null
    localStorage.setItem("timer_type", "study")
  if isNaN(localStorage.getItem("time_left")) || localStorage.getItem("time_left") is null
    switch localStorage.getItem("timer_type")
      when "study" then localStorage.setItem("time_left", study_timer_time)
      when "short_break" then localStorage.setItem("time_left", short_break_time)
      when "long_break" then localStorage.setItem("time_left", long_break_time)
      else localStorage.setItem("time_left", study_timer_time)
  if localStorage.getItem("timer_running") is null
    localStorage.setItem("timer_running", false)

  # Set Timer dropdown title
  switch localStorage.getItem("timer_type")
    when "study" then $('#timer-select-btn').text('Study')
    when "short_break" then $('#timer-select-btn').text('Short break')
    when "long_break" then $('#timer-select-btn').text('Long break')
    else $('#timer-select-btn').text('Study')

  window.timer = setInterval( ->
    time_left = localStorage.getItem("time_left")
    if localStorage.getItem("timer_running") is "true"

      time_left -= 1
      localStorage.setItem("time_left", time_left)
      localStorage.setItem("last_interval_stopped", false)

    minutes = ("0" + Math.floor((time_left / 60))).slice(-2);
    seconds = ("0" + Math.floor((time_left % 60))).slice(-2);

    # // Display the result in the element with id="timer"
    $('#timer').html("#{minutes}:#{seconds}")

    if time_left is 0
      localStorage.setItem("timer_running", false)
      switch localStorage.getItem("timer_type")
        when "study" then alert("Time up! Have something to drink and take a walk, you'll work better after a short break"); localStorage.setItem("time_left", study_timer_time)
        when "short_break" then alert("Break over! It's time to get back to work!"); localStorage.setItem("time_left", short_break_time)
        when "long_break" then alert("Break over! It's time to get back to work!"); localStorage.setItem("time_left", long_break_time)

  , 1000)

  # Timer Controls
  $('#start-btn').click( ->
    localStorage.setItem("timer_running", true))

  $('#stop-btn').click( ->
    localStorage.setItem("timer_running", false))

  $('#reset-btn').click( ->
    localStorage.setItem("timer_running", false)
    switch localStorage.getItem("timer_type")
      when "study" then localStorage.setItem("time_left", study_timer_time)
      when "short_break" then localStorage.setItem("time_left", short_break_time)
      when "long_break" then localStorage.setItem("time_left", long_break_time)
      else localStorage.setItem("time_left", study_timer_time)
    $('#timer').html("#{time_left/60}:00")
    )

  # Timer Settings
  $('#study-timer-btn').click( ->
    localStorage.setItem("timer_running", false)
    localStorage.setItem("time_left", study_timer_time)
    localStorage.setItem("timer_type", "study")
    $('#timer-select-btn').text('Study'))

  $('#short-break-btn').click( ->
    localStorage.setItem("timer_running", false)
    localStorage.setItem("time_left", short_break_time)
    localStorage.setItem("timer_type", "short_break")
    $('#timer-select-btn').text('Short break'))

  $('#long-break-btn').click( ->
    localStorage.setItem("timer_running", false)
    localStorage.setItem("time_left", long_break_time)
    localStorage.setItem("timer_type", "long_break")
    $('#timer-select-btn').text('Long break'))

  $('#save-timer-settings').click( ->

    study_timer_time = $('#study_timer_input').val()*60
    short_break_time = $('#short_break_input').val()*60
    long_break_time = $('#long_break_input').val()*60
    localStorage.setItem("timer_running", false)
    clearInterval(window.timer)
    )

  $('#logout-btn').click( ->
    localStorage.clear())

$(document).on 'turbolinks:click', ->
  clearInterval(window.timer)
