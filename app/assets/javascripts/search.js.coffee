ready = ->
  $('#nav-search').select2
    placeholder: 'Search album'
    minimumInputLength: 1
    width: '15em'
    ajax:
      url: $('#nav-search').attr('data-url')
      method: 'post'
      dataType: 'json'
      data: (term, page)->
        {q: term, page_limit: 10, scope: $('.search-check input').prop('checked')}
      results: (e, callback)->
        {results: e}
    formatResult: (e)->
      "#{e.name} by #{e.artist}"
    formatSelection: (e)->
      e.name
    dropdownCssClass: 'search-select-dropdown'
    containerCssClass: 'search-select'

  $('#nav-search').bind 'change', (e)->
    Turbolinks.visit("#{$('#nav-search').attr 'data-url-show'}/#{e.val}")

$(document).on('page:load', ready)
$ ->
  ready()
