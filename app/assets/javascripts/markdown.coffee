actions = ['preview', 'edit']
converter = new Showdown.converter();

toggleUnselected = (option, options) ->
  if not option.hasClass('selected')
    $("#preview-description").html(converter.makeHtml($("#edit-description").val()))
    for option in options
      $("##{option}-description").toggle()
      $("a.[action='#{option}']").toggleClass('selected')

toggleive = (action, options = actions) ->
  $("a.[action='#{action}']").live('click', (event) ->
    event.preventDefault()
    toggleUnselected($(this), options)
  )

for action in actions
  toggleive(action)