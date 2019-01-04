$(function () {
    $("#acceptance_request_request_to").change(function(){
        var request_to = $(this).val()
        $.ajax({
            url: '/acceptance_requests/load_request_to',
            data: {request_to: request_to},
            success: function(response){
                $('#acceptance_request_to').html(response);
            }
        });
    });
});