(function() {
  var hoverize;
  hoverize = function(star) {
    var image;
    image = $(star).find('img').first();
    image.attr('src', image.attr('src').replace('transparent', 'colored'));
    return image;
  };
  $('.stars a[data-stars]').hover(function() {
    return $(this).hoverize();
  });
}).call(this);
