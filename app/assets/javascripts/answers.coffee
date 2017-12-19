# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->  
  $('.edit-answer-link').click (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $("form#edit-answer-" + answer_id).show()
  $('.a-vote').on "ajax:success", (e) ->
    [data, status, xhr] = e.detail
    rates = xhr.responseText 
    answer_id = $(this).data('answerId')
    $('.a-vote[data-answer-id= ' + answer_id + ']').children().first().html "</p> Answer rating: " + rates + "</p>"

$(document).ready(ready)  
$(document).on('turbolinks:load', ready)