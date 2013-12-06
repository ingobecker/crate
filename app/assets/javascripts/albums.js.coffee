# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

ready = ->

  if $('#album-list').length
    $('.pop_cover').each (i, v)->
      v = $(v)
      v.popover
        content: $(v.attr('data-content-selector')).html()
        html: true

  $('#album-list .panel-heading a.btn').tooltip()
  if $('#album-list[data-controller=albums]').length

    toggleTitle = (link)->
      link = $(link)
      title_swap = link.attr('data-original-title')
      link.tooltip('hide').attr('data-original-title', link.attr('data-titletoggle'))
      link.tooltip('fixTitle')
      link.tooltip('show')
      link.attr 'data-titletoggle', title_swap

    handler =
      delete: (link)->
        $(link).bind 'ajax:success', (e)->
          $(this).find('span').toggleClass 'glyphicon-plus glyphicon-minus'

      post: (link)->
        $(link).bind 'ajax:success', (e)->
          $(this).find('span').toggleClass 'glyphicon-plus glyphicon-minus'


    $('.panel-heading a.btn').each (i, v)->
      handler[$(v).attr('data-method')](this)
      $(v).click ()->
        toggleTitle v

  $.each $('.panel-collapse'), (k, v)->
    $(v).on 'show.bs.collapse', ->
      inner = $(v).find('.panel-body')
      unless inner.html().length
        $.get $(v).data('url'), (data)->
          inner.html data

$(document).on('page:load', ready)
$ ->
  ready()
