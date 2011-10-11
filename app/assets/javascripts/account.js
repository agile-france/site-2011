fold = function(list, initial, reduce) {
  var i, length;
	for(i = 0, length = list.length; i < length; i++) {
	  reduce(initial, list[i]);
	}
	return initial;
};

function Company() {
}
Company.prototype.reduce = function(initial, x) {
  t = {label: x['name']};
  initial.push(t);
};

$.getJSON('/companies', {pageless: true}, function(json) {
  var company = new Company();
  var companies = fold(json, [], company.reduce);
  $( "#company" ).autocomplete({
		source: companies
	});
})