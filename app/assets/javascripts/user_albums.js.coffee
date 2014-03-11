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

  if $('form#new_album').length
    $('form#new_album #add-track').click (e)->
      e.preventDefault()
      num = $('form#new_album .tracks .form-group').length / 2
      last_track = $('.tracks .form-group').slice(-2)
      new_track = last_track.clone()
      $.each ['name', 'duration_str'], (i, e)->
          new_track.find(".#{e}")
            .val('')
            .attr('name', "album[tracks_attributes][#{num}][#{e}]")
            .closest('.has-error').removeClass('has-error')
            .find('span').remove()
      new_track.insertAfter(last_track.last())

$(document).on('page:load', ready)
$ ->
  ready()
