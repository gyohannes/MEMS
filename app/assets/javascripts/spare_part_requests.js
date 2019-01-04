$(function () {
    $("#spare_part_request_request_to").change(function(){
        var request_to = $(this).val()
        $.ajax({
            url: '/spare_part_requests/load_request_to',
            data: {request_to: request_to},
            success: function(response){
                $('#spare_part_request_to').html(response);
            }
        });
    });
});