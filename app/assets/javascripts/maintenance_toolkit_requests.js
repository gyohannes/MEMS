$(function () {
    $("#maintenance_toolkit_request_request_to").change(function(){
        var request_to = $(this).val()
        $.ajax({
            url: '/maintenance_toolkit_requests/load_request_to',
            data: {request_to: request_to},
            success: function(response){
                $('#maintenance_toolkit_request_to').html(response);
            }
        });
    });
});