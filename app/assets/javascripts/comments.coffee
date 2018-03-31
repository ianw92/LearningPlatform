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
