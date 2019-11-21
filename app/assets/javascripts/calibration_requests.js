$(function () {
    $("#calibration_request_request_to").change(function(){
        var request_to = $(this).val()
        $.ajax({
            url: '/calibration_requests/load_request_to',
            data: {request_to: request_to},
            success: function(response){
                $('#calibration_request_to').html(response);
            }
        });
    });
});