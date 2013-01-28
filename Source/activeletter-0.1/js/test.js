$(document).ready(function () {
    $.ajax({
      type: "POST",
      url: "test.xql",
      success: function(data, textStatus, jqXHR) { 
          $('#content').html(data);
          console.log(jqXHR);
        }
    }, "json").error(function(jqXHR, textStatus, errorThrown) {
        $('#content').html(jqXHR);
        console.log(jqXHR);
        console.log(errorThrown);
    });
});