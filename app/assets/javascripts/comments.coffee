# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

toggleSubmitButtonDisabled = ->
  if $('.comment_body').val().length > 0
    $('.comment_submit_btn').removeAttr('disabled')
  else
    $('.comment_submit_btn').attr('disabled', 'disabled')

$(document).on 'turbolinks:load', ->
  # When you click on a tab to change the week, delete any unsaved comment and make the submit button disabled again
  $('[data-toggle="tab"]').each( ->
    $(this).on('click', ->
      $('.comment_body').each( -> $(this).val(''))
      toggleSubmitButtonDisabled()
      )
    )

  $('.comment_submit_btn').attr('disabled', 'disabled')
  $('.comment_body').on('keyup', toggleSubmitButtonDisabled)
