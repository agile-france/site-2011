(function() {
  var action, actions, converter, toggleUnselected, toggleive, _i, _len;
  actions = ['preview', 'edit'];
  converter = new Showdown.converter();
  toggleUnselected = function(option, options) {
    var _i, _len, _results;
    if (!option.hasClass('selected')) {
      $("#preview-description").html(converter.makeHtml($("#edit-description").val()));
      _results = [];
      for (_i = 0, _len = options.length; _i < _len; _i++) {
        option = options[_i];
        $("#" + option + "-description").toggle();
        _results.push($("a.[action='" + option + "']").toggleClass('selected'));
      }
      return _results;
    }
  };
  toggleive = function(action, options) {
    if (options == null) {
      options = actions;
    }
    return $("a.[action='" + action + "']").live('click', function(event) {
      event.preventDefault();
      return toggleUnselected($(this), options);
    });
  };
  for (_i = 0, _len = actions.length; _i < _len; _i++) {
    action = actions[_i];
    toggleive(action);
  }
}).call(this);
