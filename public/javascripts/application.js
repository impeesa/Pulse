// add AJAX to account detail week select.
$(function() {
  $('#week').change(function() {
    var selectedWeek = $(this).val()
    window.location.replace('?week=' + selectedWeek)
  })

  $('#main-nav-menu').ptMenu();

  $('#save-settings').live('click', function() {
    $(this).closest('form').submit();
  })

  $('#local-login').live('click', function() {
    $(this).closest('form').submit();
  });

  $('#reset-width-height').live('click', function() {
    $('#chart_width').val(parseInt($('#chart_width').attr('default-width')));
    $('#chart_height').val(parseInt($('#chart_height').attr('default-height')));
    return false;
  });
})
