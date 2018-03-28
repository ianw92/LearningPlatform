# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
  $('#content-type-selector').on 'change', ->
    selector = $(this).val()
    content_uploader = $('#content-upload-form-option')
    youtube_uploader = $('#youtube-link-form-option')
    submit_button = $('#submit-content-btn')
    switch selector
      when 'PDF'
        content_uploader.show()
        youtube_uploader.hide()
        $('#lecture_module_content_youTube_link').val('')
        submit_button.show()
      when 'YouTube Video'
        content_uploader.hide()
        youtube_uploader.show()
        $('#lecture_module_content_youTube_link').val('')
        submit_button.show()
      else
        content_uploader.hide()
        youtube_uploader.hide()
        submit_button.hide()
        $('#lecture_module_content_youTube_link').val('')
