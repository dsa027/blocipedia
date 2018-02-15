function matchCustom(params, data) {
    // If there are no search terms, return all of the data
    if ($.trim(params.term) === '') {
      return data;
    }

    // Do not display the item if there is no 'text' property
    if (typeof data.text === 'undefined') {
      return null;
    }

    // `params.term` should be the term that is used for searching
    // `data.text` is the text that is displayed for the data object
    if (data.text.indexOf(params.term) > -1) {
      var modifiedData = $.extend({}, data, true);
      modifiedData.text += ' (matched)';

      // You can return modified objects from here
      // This includes matching the `children` how you want in nested data sets
      return modifiedData;
    }

    // Return `null` if the term should not be displayed
    return null;
}

$(document).ready(function() {
  $("#collab-dropdown").select2({
      matcher: matchCustom,
      placeholder: "Enter email"
  })
  $("#collab-dropdown").on('change', function() {
    $.ajax({
      url: '/collaborators/',
      type: 'POST',
      dataType: 'json',
      data: {
        id: $("#collab-dropdown").val(),
      },
    });
  })

  $('#collab-dropdown').on("select2:unselecting", function() {
    var v = $('#collab-dropdown').val();
    if (v.length === 1) {
      $.ajax({
        url: '/collaborators/',
        type: 'POST',
        dataType: 'json',
        data: {
          id: [v + "/delete"],
        },
      });
    }
  });
})
