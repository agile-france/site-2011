$.getJSON('/companies', function(json) {
  var company = new Company();
  var companies = fold(json, [], company.reduce);
  $( "#company" ).autocomplete({
		source: companies
	});
})