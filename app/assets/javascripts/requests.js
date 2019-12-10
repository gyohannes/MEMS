$(function () {
    $('input[type="radio"]').on('change', function () {
        var action = $(this).val()
        if (action == 'Out Sourced'){
            $("#forward").hide()
            $("#outsource").show()
        }else if (action == 'Forwarded') {
            $("#forward").show()
            $("#outsource").hide()
        }else{
            $("#forward").hide()
            $("#outsource").hide()
        }
        $( "select" ).select2();
    })
    $("#outsource").hide()
    $("#forward").hide()
});