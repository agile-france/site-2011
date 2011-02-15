describe('Markdown preview', function() {
  var editArea;
  var edit;
  var previewArea;
  var preview;

  beforeEach(function() {
   loadFixtures('markdown.html');
   editArea = $('#edit-description');
   edit = $('a.[action="edit"]');
   previewArea = $('#preview-description');
   preview = $('a.[action="preview"]');
  });

  describe('clicking preview', function() {
   beforeEach(function() {
     editArea.text('#markdowned#');
     preview.click();
   });
   it('toggles visibly from edit to preview area', function() {
     expect(editArea).not.toBeVisible();
     expect(previewArea).toBeVisible();
   });
   it('add selected class to preview', function() {
     expect(preview.hasClass('selected')).toBeTruthy();
   });
   it('remove selected class from edit', function() {
     expect(edit.hasClass('selected')).toBeFalsy();
   });
   it('preview area has transformed content', function() {
     expect(previewArea.text()).toBe('<h1>markdowned</h1>');
   });
  });

  describe('clicking twice on preview is the same as clicking once', function() {
   beforeEach(function() {
     preview.click();
     preview.click();
   });
   it('is the same ...', function() {
     expect(previewArea).toBeVisible();
   });
  }); 

  describe('back to edit mode', function() {
   beforeEach(function() {
     preview.click();
     edit.click();
   });
   it('makes edit area visible', function() {
     expect(editArea).toBeVisible();
   });
   it('makes preview area not visible', function() {
     expect(previewArea).not.toBeVisible();
   });
  });
});