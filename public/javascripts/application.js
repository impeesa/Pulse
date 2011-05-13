// add AJAX to account detail week select.
$(function() {
  $('#week').change(function() {
    var selectedWeek = $(this).val()
    window.location.replace('?week=' + selectedWeek)
  })

  $('#main-nav-menu').ptMenu();

  $('#save-settings, #save-permissions').live('click', function() {
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

  $('input').keyup(function(e) {
    if (e.keyCode == 13) {
      $(this).closest('form').submit();
    }
  });

  $('#groups_select_all').bind('change', function() {
    var sa = $(this);

    if (sa.attr('checked') == true) {
      $.each($('#charts_groups').find('input[type=checkbox]'), function(index, element) {
        $(element).attr('checked', true);  
      });
    } else {
      $.each($('#charts_groups').find('input[type=checkbox]'), function(index, element) {
        $(element).attr('checked', false);  
      });
    }
  });

  $('.charts_groups').bind('click', function() {
    if (all_checked()) {
      $('#groups_select_all').attr('checked', true);
    } else {
      $('#groups_select_all').attr('checked', false);
    }
  });

  function all_checked() {
    all_are_checked = true;
    $.each($('#charts_groups').find('input[type=checkbox]'), function(index, element) {
      if ($(element).attr('checked') == false) {
        all_are_checked = false;
        return;
      }
    });
    return all_are_checked;
  }
})

