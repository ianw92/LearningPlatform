# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Toggle todo-list popup
$(document).on 'turbolinks:load', ->
  $('[data-toggle="popover"]').popover({
    html:true
    trigger:'click'
    });

# $(document).on 'turbolinks:load', ->
#   $('[data-toggle="popover"]').on("click", ->
#     console.log("test");
#     $('[data-toggle="popover"]').data('bs.popover').setContent("<%=j render partial:'shared/todo_lists_accordion', locals:{ type: 'popover' } %>");
#     );
