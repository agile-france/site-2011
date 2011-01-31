fold = function(list, initial, reduce) {
  var i, length;
	for(i = 0, length = list.length; i < length; i++) {
	  reduce(initial, list[i]);
	}
	return initial;
};
