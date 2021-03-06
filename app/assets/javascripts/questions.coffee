# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.edit_question_link').click (e) ->
    e.preventDefault();
    $(this).hide();
    question_id = $(this).data('questionId')
    $("form#edit-question-" + question_id).show()
  $('.q-vote').on "ajax:success", (e) ->
    [data, status, xhr] = e.detail
    rates = xhr.responseText;
    $('.question-score').html "Question rating:" + rates
$(document).ready(ready)  
$(document).on('turbolinks:load', ready)