$(function () {
    $("#training_request_request_to").change(function(){
        var request_to = $(this).val()
        $.ajax({
            url: '/training_requests/load_request_to',
            data: {request_to: request_to},
            success: function(response){
                $('#training_request_to').html(response);
            }
        });
    });
});