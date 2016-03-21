$('#messages').infinitePages({
  buffer: 200,
  loading: function() {
    $(this).text('Loading next page...')
  },
  error: function() {
    $(this).button('There was an error, please try again')
  }
})
