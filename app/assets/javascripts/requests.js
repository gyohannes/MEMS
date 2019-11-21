$(function () {
    $('input[type="radio"]').on('change', function () {
        var action = $(this).val()
        if (action == 'Forwarded'){
            $("#forward").show()
            $( "select" ).select2();
        }else {
            $("#forward").hide()
        }
    })
    $("#forward").hide()
});