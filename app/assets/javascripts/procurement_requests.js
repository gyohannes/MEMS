$(function () {
    $("#procurement_request_request_to").change(function(){
        var request_to = $(this).val()
        $.ajax({
            url: '/procurement_requests/load_request_to',
            data: {request_to: request_to},
            success: function(response){
                $('#procurement_request_to').html(response);
            }
        });
    });
});