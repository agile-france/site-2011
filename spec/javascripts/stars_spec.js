describe('stars effects', function() {
  var stars;
  beforeEach(function() {
    loadFixtures('stars.html');
    stars = $('.stars a[data-stars]');
  });
  
  it('validates fixture', function() {
    expect(stars.length).toBe(5);
  });
  
  describe('mousing over star 3', function() {
    beforeEach(function() {
      $(stars[2]).mouseover();
    });
    it('fails', function() {
      expect(false).toBeTruthy();
    });
    it('toggles image on star 3', function() {
      image = $(stars[2]).find('img').first();
      expect($(image).attr('src')).toMatch('stars-colored');
    });
  });
});