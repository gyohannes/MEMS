$(function () {
    $("#request_status_epsa_team_id").change(function(){
        var team = $(this).val()
        $.ajax({
            url: '/request_statuses/load_status',
            data: {team: team},
            success: function(response){
                $('#epsa_status').html(response);
            }
        });
    });
});