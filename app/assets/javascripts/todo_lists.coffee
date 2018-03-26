# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Toggle todo-list popup
$(document).on 'turbolinks:load', ->
  $('[data-toggle="popover"]').popover({
    html:true
    trigger:'click'
    });

  $(document).on('click', '#show_hide_completed_tasks_btn', ->
    if $('.task_completed').hasClass('task_show')
      $(this).html('Show completed')
    else
      $(this).html('Hide completed')
    $('.task_completed').toggleClass('task_show')
    )
