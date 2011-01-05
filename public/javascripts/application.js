// add AJAX to account detail week select.
$(function() {
  $('#week').change(function() {
    var selectedWeek = $(this).val()
    window.location.replace('?week=' + selectedWeek)
  })
})
