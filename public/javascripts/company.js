function Company() {
}
Company.prototype.reduce = function(initial, x) {
  t = {label: x['name']};
  initial.push(t);
};
