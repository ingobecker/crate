ready = ->

  if $('#album-list[data-controller=user_albums]').length

    handler =
      delete: (link)->
        $(link).bind 'ajax:success', (e)->
          $(this).closest('.panel').fadeOut ->
            $(this).remove()

    $('.panel-heading a.btn').each (i, v)->
      handler[$(v).attr('data-method')](this)
      $(v).tooltip()

$(document).on('page:load', ready)
$ ->
  ready()
