describe('Company', function() {  
  describe('fold', function() {    
    beforeEach(function() {
      list = [{"_id":"123","name":"Aha"},{"_id":"456","name":"Onoes"}];
    })
    
    it('folds using initial value', function() {
      reduce = function(initial, x) {
        initial.push(x);
      };
      expect(fold(list, [], reduce)).toEqual(list);  
    })
    
    it('transform values', function() {
      company = new Company();
      expect(fold(list, [], company.reduce)).toEqual([{value:"123", name:"Aha"},{value:"456", name:"Onoes"}]);  
    })
  })
})
