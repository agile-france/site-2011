growl = function(selector) {
  $(selector).hide().children().each(function(_index, element) {
    $.jGrowl(element.text);
  });
};