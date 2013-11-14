# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->
  $.each $('.panel-collapse'), (k, v)->
    $(v).on 'show.bs.collapse', ->
      inner = $(v).find('.panel-body')
      unless inner.html().length
        $.get $(v).data('url'), (data)->
          inner.html data

$(document).on('page:load', ready)
$ ->
  ready()
