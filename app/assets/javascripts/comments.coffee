# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

toggleCommentSubmitButtonDisabled = ->
  valid_input = false
  $('.comment_body').each( ->
    if $(this).val().length > 0
      valid_input = true
    )
  if valid_input
    $('.comment_submit_btn').prop('disabled', false)
  else
    $('.comment_submit_btn').prop('disabled', true)


$(document).on 'turbolinks:load', ->
  $('.comment_submit_btn').attr('disabled', 'disabled')

  $(document).on('keyup', ->
    $('.comment_body').on('keyup', toggleCommentSubmitButtonDisabled)
    $('[data-toggle="tab"]').each( ->
      $(this).on('click', ->
        $('.comment_body').each( -> $(this).val(''))
        toggleCommentSubmitButtonDisabled()
        )
      )
    )

  $(document).on('click', ->
    $('span[id^=comment_][id$=_body]').on('input', ->
      # Use bound class as a tag to stop blur event firing multiple times if the same comment is edited multiple times
      if !$(this).hasClass('bound')
        $(this).on('blur', ->

          Rails.ajax
            url: ($(this).data('url') + '?body=' + $(this)[0].textContent.trim())
            type: 'PATCH'
          )
      $(this).addClass('bound')
      )
    )
