# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

document.addEventListener 'turbolinks:load', ->

  $(document).on('click', ->
    $('.tasks-sortable').sortable update: (e, ui) ->
      Rails.ajax
        url: $(this).data('url')
        type: 'PATCH'
        data: $(this).sortable('serialize')

    $('.todo_lists div[id^=task_][id$=_title], div[id^=task_][id$=_title_popover]').on('input', ->
      # Use bound class as a tag to stop blur event firing multiple times if the same comment is edited multiple times
      if !$(this).hasClass('bound')
        $(this).on('blur', ->
          Rails.ajax
            url: ($(this).data('url') + '?title=' + $(this)[0].textContent.trim())
            type: 'PATCH'
          )
      $(this).addClass('bound')
      )
    )
