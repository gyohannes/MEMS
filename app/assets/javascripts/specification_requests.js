$(function () {
    $("#specification_request_request_to").change(function(){
        var request_to = $(this).val()
        $.ajax({
            url: '/specification_requests/load_request_to',
            data: {request_to: request_to},
            success: function(response){
                $('#specification_request_to').html(response);
            }
        });
    });
});