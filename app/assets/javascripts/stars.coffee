hoverize = (star) ->
  image = $(star).find('img').first()
  image.attr('src', image.attr('src').replace('transparent', 'colored'))
  image

$('.stars a[data-stars]').hover(() ->
  $(this).hoverize()
)