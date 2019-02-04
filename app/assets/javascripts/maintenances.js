$(function () {
    $('#maintenance_maintenance_request_id').on('change', function () {
        var maintenance_request = $(this).val();
        $.ajax({
            url: '/maintenances/load_maintenance_requests',
            data: { maintenance_request: maintenance_request },
            success: function (response) {
                $('#equipment_display').html(response)
            }
        });
    })
});